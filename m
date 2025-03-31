Return-Path: <linux-pm+bounces-24639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8CA7637D
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 11:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495CE169210
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1718B46E;
	Mon, 31 Mar 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRpqIX7j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070D1953A1
	for <linux-pm@vger.kernel.org>; Mon, 31 Mar 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414347; cv=none; b=HFU6M1FVPnce9pGtv26h9i8aBU4bEhiJL40wZjJ9qLn3SheANj4qMHmkZW8CEt5af9XmL0JcGa5NKOPbYTdJ76Fo9DlLOhckEajBYsfu2+6dDf5FXbqwftic4EleKD4S3gEW/yUwez62dlP0geVAdpvalQ0nFNZHRFvAwCToU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414347; c=relaxed/simple;
	bh=8GyrqIAXJmnLWE+QR/uNM2y8SfLju5Q2OARDtyhAtl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pS8eI4c+ejioUo1JwWyAnJvx0T2qsPaPItfKrOiLgrWWbHdrWzZtpr34gLIf5aZOB6jjqf98gdYAxEVCYWWQJ2L/uxZaUKp55xFN0DAD3tRkZ1hrlm+m8iTuBydIkVXYZTKma/mwH10i6hMYWSMq5PCwu1IVB05Y+huBj4eqilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRpqIX7j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac9aea656so3531031f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Mar 2025 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743414344; x=1744019144; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIZXc8U9GSYZgsDRfKdNtiEgygY5UmV+phshMkWCfHM=;
        b=wRpqIX7jWBrGZ4KMohKO9eTYnNSn0ckTJ/YLtPeK6wCTQQFTDsnywMfhuCTEFSTj0p
         OC+tS5Z6TpNfVaz7e/exnIqLqSzAlxclxvtoK21pCEm/Z+OibD0BUbrqbpJjvRi/CHa+
         YrGqkaauDpdQREh6yO2Z3290IQMoRfTOPAAxAWGEOiA8J5ls4rMCsS9WluXIb4Tou7G1
         yYD52TCiPI64q+NOxuSO4vPqA7Lu7Q4qQ9qxUsZ1YNycDawa90noU6zFrF0WYAsnWT8o
         nd1ZgEp5C6l59yhCHI0XvuUVBIph6pOoV8NuJPhfuNUM2I/uMr05+nEm1cgXVxn+Xlvl
         lhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743414344; x=1744019144;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIZXc8U9GSYZgsDRfKdNtiEgygY5UmV+phshMkWCfHM=;
        b=j7sSZ6oEA1L3hbCDMfJu8rBTGNmHGH2o3/pQz/uoYVne1sjSNYM6/dNaykugURhwLY
         s6s185jA7r5zcu4bk19mZlPojer73iCwWSHGD/jtZrH1C7xY2p/vPNbcHV2sBL2ru1l6
         w9EZ6INpV8M7DxyXavQV6zxqn1DCUDnExB3begrg266XXGnO/3BbeAntkANDikSrstNO
         E+pVrUvwdQVEP0RPTWR7AFChBhhuUSCE8F1M8RFpnaDZq10d9iIJLZb+9XPt6DaoQz7F
         jHE2BrTY6/9ZFov85YQG1F33tO96v2Fso/ok79ZgK7yBhNtO1jxvCSbiCvw6FNx7ciaj
         IKeg==
X-Gm-Message-State: AOJu0YwvDdtBLntIYHaJMzDUjnkzJ4VTfy8Ijd55ZiBU53MmIsGJLEw1
	I8flgSqWc8YJDFFjMAxAANiQiobkIgvWUPgctnCA0qGWcU977jZEsyY0uv1gSsfKFoFw/l35pIj
	Sgtg=
X-Gm-Gg: ASbGncvimUu66uk7CuUDScp4/0fSKiJjzbHFF0C7EgeXahoZiKNmX8sazmmX/7fhrva
	1OTmZx/VGsJROvlbs55VX+Zh5OPx0KS6vl5p/vmjtL/nGJwjCC0zxiPdl8hvzw6kJ7x9VrmN5H7
	oeRYhjZP6rZANGVOgWso5BKWUA2QnSS6SuRcZ/Ubfsl+gCk/EM2b1NhwPbriQwQW2atBpswrbbj
	h6MkEPRSIL+fga5+Vx6qycP7V3Ntozx5wvoVVSjlNh3QhgvrDxGvtZ5mxXKdWNvR1HQtUsw+2nS
	LpFITUPo20aAkvMaQtYSApu8quuh3AoNeNSTzKS5XEWB/vWEKA==
X-Google-Smtp-Source: AGHT+IE6tUoj3q6i8uD6WXTzYloCv4NfTssYi82juGjuw3XqZtU2u81FwRk1zL9G6woAWNZTRtJLEA==
X-Received: by 2002:a05:6000:2706:b0:39c:1257:cd3f with SMTP id ffacd0b85a97d-39c1257d4fbmr4127877f8f.57.1743414344306;
        Mon, 31 Mar 2025 02:45:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d82efe389sm158473405e9.19.2025.03.31.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 02:45:43 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:45:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] PM / Domains: Introduce dev_pm_domain_attach_by_name()
Message-ID: <d995010a-ef5f-40bc-b33b-62213972e605@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ulf Hansson,

Commit 27dceb81f445 ("PM / Domains: Introduce
dev_pm_domain_attach_by_name()") from Jun 29, 2018 (linux-next),
leads to the following Smatch static checker warning:

	drivers/pmdomain/imx/imx8m-blk-ctrl.c:331 imx8m_blk_ctrl_probe()
	warn: 'bc->bus_power_dev' can also be NULL

drivers/pmdomain/imx/imx8m-blk-ctrl.c
    214         bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
    215         if (IS_ERR(bc->bus_power_dev)) {

The problem is the dev_pm_domain_attach_by_name() function can return
NULL when the power domain is not needed but this driver assumes that
checking for IS_ERR() is sufficient.

    216                 if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
    217                         return dev_err_probe(dev, -EPROBE_DEFER,
    218                                              "failed to attach power domain \"bus\"\n");
    219                 else
    220                         return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
    221                                              "failed to attach power domain \"bus\"\n");
    222         }
    223 
    224         for (i = 0; i < bc_data->num_domains; i++) {
    225                 const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
    226                 struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
    227                 int j;
    228 
    229                 domain->data = data;
    230                 domain->num_paths = data->num_paths;
    231 
    232                 for (j = 0; j < data->num_clks; j++)
    233                         domain->clks[j].id = data->clk_names[j];
    234 
    235                 for (j = 0; j < data->num_paths; j++) {
    236                         domain->paths[j].name = data->path_names[j];
    237                         /* Fake value for now, just let ICC could configure NoC mode/priority */
    238                         domain->paths[j].avg_bw = 1;
    239                         domain->paths[j].peak_bw = 1;
    240                 }
    241 
    242                 ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
    243                 if (ret) {
    244                         if (ret != -EPROBE_DEFER) {
    245                                 dev_warn_once(dev, "Could not get interconnect paths, NoC will stay unconfigured!\n");
    246                                 domain->num_paths = 0;
    247                         } else {
    248                                 dev_err_probe(dev, ret, "failed to get noc entries\n");
    249                                 goto cleanup_pds;
    250                         }
    251                 }
    252 
    253                 ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
    254                 if (ret) {
    255                         dev_err_probe(dev, ret, "failed to get clock\n");
    256                         goto cleanup_pds;
    257                 }
    258 
    259                 domain->power_dev =
    260                         dev_pm_domain_attach_by_name(dev, data->gpc_name);
    261                 if (IS_ERR_OR_NULL(domain->power_dev)) {
    262                         if (!domain->power_dev)
    263                                 ret = -ENODEV;
    264                         else
    265                                 ret = PTR_ERR(domain->power_dev);

This call is done correctly, I guess?

    266                         dev_err_probe(dev, ret,
    267                                       "failed to attach power domain \"%s\"\n",
    268                                       data->gpc_name);
    269                         goto cleanup_pds;
    270                 }

Two other cases are:

=========================================================
drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1844 a6xx_gmu_wrapper_init() warn: 'gmu->cxpd' can also be NULL
        gmu->initialized = true;

        return 0;

detach_cxpd:
--->    dev_pm_domain_detach(gmu->cxpd, false);

err_mmio:
        iounmap(gmu->mmio);

        /* Drop reference taken in of_find_device_by_node */
=========================================================
drivers/gpu/drm/msm/adreno/a6xx_gmu.c:2025 a6xx_gmu_init() warn: 'gmu->cxpd' can also be NULL

remove_device_link:
        device_link_del(link);

detach_cxpd:
--->    dev_pm_domain_detach(gmu->cxpd, false);

err_mmio:
        iounmap(gmu->mmio);
        if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "rscc"))
                iounmap(gmu->rscc);

It's not just as simple as adding a NULL check to dev_pm_domain_detach()
because the whole driver assumes it is a valid pointer.

regards,
dan carpenter

