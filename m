Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030521226A0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfLQI0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 03:26:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41278 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfLQI0D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 03:26:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so12741344otc.8
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 00:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RCsXWRQL8MbBqA3nzPedeUVktcXE433aFjMdMK6P0Q=;
        b=DBw+LYPNzcqaRXRQzhFJQ5nNFxbEpVkv8OAt/J5i9G+JRkKTjWxhrRANwTGWeysADg
         2mdBgmmbcnrrIZZ2YdH5wnbx2XRJ2G5hd80mSQX+6RaELYSWcbu35QziGWy6K0nxWIig
         JrvECyy08q0/Pmr5Z/XG7cEf1Lc3w7vd0/p09cCo8hd9LpGtdlR0xUGSUXTvA/MhALSq
         6OqtJMK5sLormwb9w29EHoZ+ffMxfNhYmnlmXqCJy/09YbcsW9cP2MRXW36Uu724f/+Y
         beBIO9gcSP9+o608ZR+51lKGvHjZHF/DasAABejcXPVo+3IgpBNlwJjA1ousZMTaixfC
         5zaA==
X-Gm-Message-State: APjAAAWLXi6nO53JgO/LO1zwPbVACVkLe+gg6ghImlpnfOMAgislEUGV
        /1B0fO9Oi2NHcc2PGHMdmbdgnMD04UncMnSIMcE=
X-Google-Smtp-Source: APXvYqxHgOE+1lmkd8stwyEcR2aK625Dy6IAxDSXIlZJCmV/iI4jQG1Lk+VEOc+6SzEyQGLgbqop1ZcrKJXKZOz5ahk=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr35337790ote.118.1576571163148;
 Tue, 17 Dec 2019 00:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20191217015623.10073-1-rui.zhang@intel.com>
In-Reply-To: <20191217015623.10073-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Dec 2019 09:25:51 +0100
Message-ID: <CAJZ5v0iXJjpw78rddpnyvr5zhpZAWMpWR+Wxz96Wiso36BpGKQ@mail.gmail.com>
Subject: Re: [PATCH] powercap/intel_rapl: add support for TigerLake Mobile
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 2:56 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add TigerLake Mobile support in intel_rapl driver.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index a67701ed93e8..9f4119c42651 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -980,6 +980,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
>         INTEL_CPU_FAM6(COMETLAKE_L, rapl_defaults_core),
>         INTEL_CPU_FAM6(COMETLAKE, rapl_defaults_core),
> +       INTEL_CPU_FAM6(TIGERLAKE_L, rapl_defaults_core),
>
>         INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
>         INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
> --

Applying as 5.6 material, thanks!
