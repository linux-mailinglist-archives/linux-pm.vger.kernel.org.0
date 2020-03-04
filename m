Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31700178DD5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 10:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgCDJxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 04:53:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33149 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgCDJxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 04:53:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so1510909oig.0;
        Wed, 04 Mar 2020 01:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWiXu1+kJXOlwOOpFNo5aE1XWbQqXbi+uifPWRjlrfo=;
        b=RqAnTBJ0zv90EjnDJ2daFDK1OQOcKTp0W5oHkdnUnf4UhSfDRrT7yvGPcSWTlu6zYB
         PfbJu0M6WDnS67PZm6BidVyYcdCFRuX25qGLm0Pkw3X2OYg1aZ58UadTp+upFi9WV2xq
         VtTr5dVjGrF+M7RqmtkUtqHLdOk073Ac3ihvQVLNygKmZcAODXBLOkpDqREZW7GwXVSj
         W1Byi33qA1UufVOi5tesRi0TgGP+UYVrR1KDCak24oUGTb8ciLrkiO4OWQhty8oqcCuh
         pr+hsmeoC8fmxncqn8JNYpeFxbYDPlOLWuIk649lEsIMZeuN7Q07o+voSmvfycSTOrfl
         yUjQ==
X-Gm-Message-State: ANhLgQ1ErAOmQeWI+yeg5OknCgkt+mdzWOG48t2eHP1RSbyinVaXcdRY
        rkrpO8fRFmJ85zs5buzp3NAx3JWe/PDlU6jO/Cg=
X-Google-Smtp-Source: ADFU+vtVWZhGfGf6R94WwxIgGmV4KIpNe17sPVEV0Rt5PoQsGytvmiGxeM29nQ7TeQliq+SetX2cwwMlR+GafhuGbNg=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr1182951oif.57.1583315629465;
 Wed, 04 Mar 2020 01:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20200227013411.1.Ica3bb9fa898499d94e0b0a2bfa08ec46c89d84fa@changeid>
 <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
In-Reply-To: <20200303170948.1.I108734f38ade020c3e5da825839dca11d2a2ff87@changeid>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Mar 2020 10:53:38 +0100
Message-ID: <CAJZ5v0j+bx5fh1wv738MNoui_SaZ-c21rDnZkWOqi_GCVg5stQ@mail.gmail.com>
Subject: Re: [PATCH v3] intel_idle: Add Comet Lake support
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 10:10 AM Harry Pan <harry.pan@intel.com> wrote:
>
> Add a general C-state table in order to support Comet Lake.
>
> Signed-off-by: Harry Pan <harry.pan@intel.com>
>
> ---
>
>  drivers/idle/intel_idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index d55606608ac8..05bce595fafe 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1067,6 +1067,11 @@ static const struct idle_cpu idle_cpu_dnv = {
>         .use_acpi = true,
>  };
>
> +static const struct idle_cpu idle_cpu_cml = {
> +       .state_table = skl_cstates,
> +       .disable_promotion_to_c1e = true,

.use_acpi = true,

missing?  Otherwise you can just use idle_cpu_skl as is, can't you?

> +};
> +
>  static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         INTEL_CPU_FAM6(NEHALEM_EP,              idle_cpu_nhx),
>         INTEL_CPU_FAM6(NEHALEM,                 idle_cpu_nehalem),
> @@ -1105,6 +1110,8 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
>         INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,      idle_cpu_bxt),
>         INTEL_CPU_FAM6(ATOM_GOLDMONT_D,         idle_cpu_dnv),
>         INTEL_CPU_FAM6(ATOM_TREMONT_D,          idle_cpu_dnv),
> +       INTEL_CPU_FAM6(COMETLAKE_L,             idle_cpu_cml),
> +       INTEL_CPU_FAM6(COMETLAKE,               idle_cpu_cml),
>         {}
>  };
>
> --
> 2.24.1
>
