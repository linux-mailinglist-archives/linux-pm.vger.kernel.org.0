Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A20112383
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 08:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfLDHVi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 02:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfLDHVi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Dec 2019 02:21:38 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE8C207DD;
        Wed,  4 Dec 2019 07:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575444097;
        bh=Q7UQtyjeL4VxDdPZbdi+q/RbmUIJQHrhYLQLjTPSM8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=scjli08YhzbQ71a5MiUEEXeyW3ha1zKopSZljr0w79UvE+JTYeSW7guqDE4URontH
         cY4S1vi9qNsekE213yRoedqvPleTmgApZFv+7aVcKRsKsIet2wXlvZhif8eBGkljHu
         jedJV77FMHCj0FOG0ax9xRsOg+D3AIIVckXKlZu4=
Received: by mail-lj1-f180.google.com with SMTP id d20so6759750ljc.12;
        Tue, 03 Dec 2019 23:21:36 -0800 (PST)
X-Gm-Message-State: APjAAAUCHuefyBShJ8ntz8fW/idFBVfOmOIytUtDJZcbfAzQBSX1AHgY
        cvCgWn6Oet7LKliXGab1CIe+bVMJgR4/DHT42/Y=
X-Google-Smtp-Source: APXvYqwNNK1x1NLVWqTX1pUtd2l/D+1CGp50LeHoWr4EsfqECHGq9Ol2fRGuTlaaBQ9PWKKVzxVNQbuhTjUQLBKNMoM=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr981936ljj.225.1575444094869;
 Tue, 03 Dec 2019 23:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20191202152520.27558-1-angus@akkea.ca> <20191202152520.27558-2-angus@akkea.ca>
In-Reply-To: <20191202152520.27558-2-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Dec 2019 15:21:23 +0800
X-Gmail-Original-Message-ID: <CAJKOXPcpW_uK=Y5+S0YmabrkAQ87vQZrjC5g3cB7WENbW49nPg@mail.gmail.com>
Message-ID: <CAJKOXPcpW_uK=Y5+S0YmabrkAQ87vQZrjC5g3cB7WENbW49nPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] power: supply: max17042: add MAX17055 support
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@puri.sm
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2 Dec 2019 at 23:27, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> The MAX17055 is very similar to the MAX17042 so extend the driver.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/max17042_battery.c | 15 ++++++--
>  include/linux/power/max17042_battery.h  | 48 ++++++++++++++++++++++++-
>  2 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 0dfad2cf13fe..cecf6e2d8329 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -282,6 +282,8 @@ static int max17042_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>                 if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
>                         ret = regmap_read(map, MAX17042_V_empty, &data);
> +               else if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
> +                       ret = regmap_read(map, MAX17055_V_empty, &data);
>                 else
>                         ret = regmap_read(map, MAX17047_V_empty, &data);
>                 if (ret < 0)
> @@ -627,7 +629,8 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
>                         config->filter_cfg);
>         regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
>         if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047 ||
> -                       chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)
> +                       chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050 ||
> +                       chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
>                 regmap_write(map, MAX17047_FullSOCThr,
>                                                 config->full_soc_thresh);
>  }
> @@ -758,6 +761,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
>
>         if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
>                 max17042_override_por(map, MAX17042_V_empty, config->vempty);
> +       if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
> +               max17042_override_por(map, MAX17055_V_empty, config->vempty);
>         else
>                 max17042_override_por(map, MAX17047_V_empty, config->vempty);
>         max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
> @@ -765,7 +770,8 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
>         max17042_override_por(map, MAX17042_FCTC, config->fctc);
>         max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
>         max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
> -       if (chip->chip_type) {
> +       if (chip->chip_type &&
> +           (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055)) {

Since the list is growing, I would prefer here similar approach as in
max17042_write_config_regs() - explicitly list devices (white list,
not black list).

>                 max17042_override_por(map, MAX17042_EmptyTempCo,
>                                                 config->empty_tempco);
>                 max17042_override_por(map, MAX17042_K_empty0,
> @@ -929,7 +935,8 @@ max17042_get_default_pdata(struct max17042_chip *chip)
>         if (!pdata)
>                 return pdata;
>
> -       if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17042) {
> +       if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17042 &&
> +           chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055) {

The same.

Best regards,
Krzysztof
