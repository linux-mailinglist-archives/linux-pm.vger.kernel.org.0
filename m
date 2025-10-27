Return-Path: <linux-pm+bounces-36874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13CC0C08E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 08:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A8189ECD1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F026C3A7;
	Mon, 27 Oct 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zB+8ZTFA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F11DF27D
	for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 07:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548711; cv=none; b=ZFz6Nr5kdhz9+StNTGrrzUzh1dC+npzdnIey+rqpPbQhfz3ndX2/Lir3xAJwEgTBW4RUYX7uPyzpaKT2lpaZSEaaV3t+U0grU0vI2TvF0MXrd2sNHruUdaXvIVa94+KFAP9G04xTm9VmmPxHZEIDwbqMFRKM+6Izjo5QEI/eYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548711; c=relaxed/simple;
	bh=iqUA9ph6+kIZ1qP75MUE1cT/JZ8yoDuz07BzW79Hf2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=frCq71UnZxmkJ1AFPHikbNty3rFSFuoCT/cW8Z4l9og/KHv+8fzBVopdsnPtrBwzJPs47RqExxLeqGZqtsMm0nGQ0dw2MRRiXMyxdi17or7WT+/n9t7gr4jPlu8CqMc28WF05oxLY8CgYF5eQ7vbWYhqOmtxPjiiltPa0MoFRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zB+8ZTFA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4270a0127e1so3323097f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 00:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761548706; x=1762153506; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJFfYykRlBHOdi5XlphjJ7Of6rfFrNXO8UImzwMboPo=;
        b=zB+8ZTFAMBPb6xZpLRtAC3vWyo0B9DZ8+jhR3nGGsupXt+A201/cyfpdmuoDek4D6N
         V6VV8eTLQIZkibwzvdjmelxYU4Jk0+aOQNjhynHmElp20lYWOoikXKKFnIKk9vRqd53H
         LM+KV10sTkyBFdwp8ICE7aAIR8dbFt4Ly7N9MSnzsOnVbV2gcoIeonC7kIhXWa1Y5uRy
         0sAFNEE9KZOR4PBtnCqu1SrQ4aefi9UUOe5dSAEg1aVOSOWjv6b8JcMBLrs1iQtJ4hPp
         +9Yv9DMkn179EbDt7VRJjPYu2kjug7C0TOU4lp1nXGUpn75/tUX+hs0Ojk+8LI23S+Ue
         L5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761548706; x=1762153506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJFfYykRlBHOdi5XlphjJ7Of6rfFrNXO8UImzwMboPo=;
        b=GIbc02BO0IrqZw9kkbosImRrpdyUWpJ1sZbVQJEGKWQs1f4QUQv+qSLTKo8u5GXaQz
         8GHXpBrLViB5d3F/1znwJdoi+hK84SU0EMR7tAkBgPNTdHIbLy22IIxAj7K54D/oPCQ7
         yz74nHU1+IO8GtezQM5UcrRdF7GWSb1tJNHegsnJg0pTCXp9vZYR1HnRgyhEspyor764
         8EFJNtcOZ22Qq7xlBrW8rHebqJLMy4RWpn2D0CjMkV2MQ5tyAWO7ZwgacAMX9VSpwpRq
         6fKgjyhbT2n72axx/AVjyqqKi0pXc21/sbtSHigSaedgg4nCRHf6ucTau3EMjyH3vPHf
         UKpw==
X-Gm-Message-State: AOJu0YyH3NQpiVsMEUTqNaZZvRPMosV0qKAiFW6L7w26aSHAbQPSd3Yz
	/2+ja3mFD26En0VTiAqJkt/mKEbKslt0NjiXFiYA+ivjATOkw7nAgYGfC6StonX3ABE=
X-Gm-Gg: ASbGnctvrtwn5Ovk2u1gpaQA7HcdfJ7thw2PHQ8QxV6enklD3ol965KcpbdKSJlC+nC
	5zkX4Asn0yfFaUV7ddS6pJpYhRMtKqK4Y7UxsVYDO/ffaKPm66eNxlzGqJ0R+44C63hJlhmMlFC
	BtJAavpps34fD/XmuqGiVjsUmSFo7Il9aTK3k1LfBZXpta5L08w5b+hH6AhCbfJKj+zVuxjb2Om
	uBk4w+rYQuiOjfr9FXdKEvW6DM6dyutBVsIvOj/W1JJFdp8IuE9dtXdi1SQtErBIo1yG7VqPCh0
	+XEqygryXLQoJ25NHw0vKjY8vZsjEwbtRALUA80lvswQlIXbe8DJpYUcG83E9wzl9DFk5wRfkEn
	rY6hSxR0Xr93m0CZ3Pmji0phEUAZxxiqssvnpEQ2x2ohh+IdaeBRd+PufMDjxlkuJJDvXXn/FuE
	PRX2UoYw==
X-Google-Smtp-Source: AGHT+IHDnxuF6aY8pbvXwwIn4O7yBK8Zhk1QQ4A/6lD/VCtErpeSNtvVwKJ1RrIizvoFYs0suVFpwg==
X-Received: by 2002:a5d:64c4:0:b0:426:d51c:4d71 with SMTP id ffacd0b85a97d-42704d44253mr22554112f8f.8.1761548705515;
        Mon, 27 Oct 2025 00:05:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952d9e80sm12345048f8f.28.2025.10.27.00.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 00:05:05 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:05:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] pmdomain: mediatek: Add support for MT8196 SCPSYS power
 domains
Message-ID: <aP8ZneXa5pcsb_9N@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello AngeloGioacchino Del Regno,

Commit ead9cf65d50f ("pmdomain: mediatek: Add support for MT8196
SCPSYS power domains") from Sep 25, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/pmdomain/mediatek/mtk-pm-domains.c:865 scpsys_add_one_domain()
	error: we previously assumed 'pd->data' could be null (see line 840)

drivers/pmdomain/mediatek/mtk-pm-domains.c
    718 static struct
    719 generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
    720 {
    721         const struct scpsys_domain_data *domain_data;
    722         const struct scpsys_hwv_domain_data *hwv_domain_data;
    723         struct scpsys_domain *pd;
    724         struct property *prop;
    725         const char *clk_name;
    726         int i, ret, num_clks;
    727         struct clk *clk;
    728         int clk_ind = 0;
    729         u32 id;
    730 
    731         ret = of_property_read_u32(node, "reg", &id);
    732         if (ret) {
    733                 dev_err(scpsys->dev, "%pOF: failed to retrieve domain id from reg: %d\n",
    734                         node, ret);
    735                 return ERR_PTR(-EINVAL);
    736         }
    737 
    738         switch (scpsys->soc_data->type) {
    739         case SCPSYS_MTCMOS_TYPE_DIRECT_CTL:
    740                 if (id >= scpsys->soc_data->num_domains) {
    741                         dev_err(scpsys->dev, "%pOF: invalid domain id %d\n", node, id);
    742                         return ERR_PTR(-EINVAL);
    743                 }
    744 
    745                 domain_data = &scpsys->soc_data->domains_data[id];
    746                 hwv_domain_data = NULL;
    747 
    748                 if (domain_data->sta_mask == 0) {
    749                         dev_err(scpsys->dev, "%pOF: undefined domain id %d\n", node, id);
    750                         return ERR_PTR(-EINVAL);
    751                 }
    752 
    753                 break;
    754         case SCPSYS_MTCMOS_TYPE_HW_VOTER:
    755                 if (id >= scpsys->soc_data->num_hwv_domains) {
    756                         dev_err(scpsys->dev, "%pOF: invalid HWV domain id %d\n", node, id);
    757                         return ERR_PTR(-EINVAL);
    758                 }
    759 
    760                 domain_data = NULL;

NULL here.

    761                 hwv_domain_data = &scpsys->soc_data->hwv_domains_data[id];
    762 
    763                 break;
    764         default:
    765                 return ERR_PTR(-EINVAL);
    766         }
    767 
    768         pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
    769         if (!pd)
    770                 return ERR_PTR(-ENOMEM);
    771 
    772         pd->data = domain_data;
                ^^^^^^^^^^^^^^^^^^^^^^

    773         pd->hwv_data = hwv_domain_data;
    774         pd->scpsys = scpsys;
    775 
    776         if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
    777                 pd->supply = devm_of_regulator_get_optional(scpsys->dev, node, "domain");
    778                 if (IS_ERR(pd->supply))
    779                         return dev_err_cast_probe(scpsys->dev, pd->supply,
    780                                       "%pOF: failed to get power supply.\n",
    781                                       node);
    782         }
    783 
    784         num_clks = of_clk_get_parent_count(node);
    785         if (num_clks > 0) {
    786                 /* Calculate number of subsys_clks */
    787                 of_property_for_each_string(node, "clock-names", prop, clk_name) {
    788                         char *subsys;
    789 
    790                         subsys = strchr(clk_name, '-');
    791                         if (subsys)
    792                                 pd->num_subsys_clks++;
    793                         else
    794                                 pd->num_clks++;
    795                 }
    796 
    797                 pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
    798                 if (!pd->clks)
    799                         return ERR_PTR(-ENOMEM);
    800 
    801                 pd->subsys_clks = devm_kcalloc(scpsys->dev, pd->num_subsys_clks,
    802                                                sizeof(*pd->subsys_clks), GFP_KERNEL);
    803                 if (!pd->subsys_clks)
    804                         return ERR_PTR(-ENOMEM);
    805 
    806         }
    807 
    808         for (i = 0; i < pd->num_clks; i++) {
    809                 clk = of_clk_get(node, i);
    810                 if (IS_ERR(clk)) {
    811                         ret = PTR_ERR(clk);
    812                         dev_err_probe(scpsys->dev, ret,
    813                                       "%pOF: failed to get clk at index %d\n", node, i);
    814                         goto err_put_clocks;
    815                 }
    816 
    817                 pd->clks[clk_ind++].clk = clk;
    818         }
    819 
    820         for (i = 0; i < pd->num_subsys_clks; i++) {
    821                 clk = of_clk_get(node, i + clk_ind);
    822                 if (IS_ERR(clk)) {
    823                         ret = PTR_ERR(clk);
    824                         dev_err_probe(scpsys->dev, ret,
    825                                       "%pOF: failed to get clk at index %d\n", node,
    826                                       i + clk_ind);
    827                         goto err_put_subsys_clocks;
    828                 }
    829 
    830                 pd->subsys_clks[i].clk = clk;
    831         }
    832 
    833         if (scpsys->domains[id]) {
    834                 ret = -EINVAL;
    835                 dev_err(scpsys->dev,
    836                         "power domain with id %d already exists, check your device-tree\n", id);
    837                 goto err_put_subsys_clocks;
    838         }
    839 
    840         if (pd->data && pd->data->name)
                    ^^^^^^^^
Check for NULL

    841                 pd->genpd.name = pd->data->name;
    842         else if (pd->hwv_data && pd->hwv_data->name)
    843                 pd->genpd.name = pd->hwv_data->name;
    844         else
    845                 pd->genpd.name = node->name;
    846 
    847         if (scpsys->soc_data->type == SCPSYS_MTCMOS_TYPE_DIRECT_CTL) {
    848                 pd->genpd.power_off = scpsys_power_off;
    849                 pd->genpd.power_on = scpsys_power_on;
    850         } else {
    851                 pd->genpd.power_off = scpsys_hwv_power_off;
    852                 pd->genpd.power_on = scpsys_hwv_power_on;
    853 
    854                 /* HW-Voter code can be invoked in atomic context */
    855                 pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
    856         }
    857 
    858         /*
    859          * Initially turn on all domains to make the domains usable
    860          * with !CONFIG_PM and to get the hardware in sync with the
    861          * software.  The unused domains will be switched off during
    862          * late_init time.
    863          */
    864         if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF)) {
--> 865                 if (scpsys_domain_is_on(pd))
                                                ^^
The patch adds an unchecked dereference of pd->data in the
scpsys_domain_is_on() function.


    866                         dev_warn(scpsys->dev,
    867                                  "%pOF: A default off power domain has been ON\n", node);
    868         } else {
    869                 ret = pd->genpd.power_on(&pd->genpd);
    870                 if (ret < 0) {
    871                         dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
    872                         goto err_put_subsys_clocks;
    873                 }
    874 
    875                 if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
    876                         pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
    877         }
    878 

regards,
dan carpenter

