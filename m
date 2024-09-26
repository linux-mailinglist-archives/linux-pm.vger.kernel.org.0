Return-Path: <linux-pm+bounces-14808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989D9870B5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29051F220C5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88361AD407;
	Thu, 26 Sep 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+uhXyD3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A11AC881
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344270; cv=none; b=KVMQBzjM8msRJW6R1rsC+hLnJv5EY4+6/1UTYC1eEvRv9eMenP0G04F9KOkThxThx5hpsGrzJOnFCR+dX+MosLeuXfL0YL8G0kfxaeu8y8PbIV34y7GX/LJc9luG5t4RIykpIJ5HQjrQxIQO48rAy5XRQ/PYS6/kULiVocJzUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344270; c=relaxed/simple;
	bh=/w1FcH9Oh+ILgA3UAivggq45abBQvNH8QV2ZMvrygYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DwH8WAaDzNq4fGSM6WYNqvouMe9jUFvpz67oDDw9eohill23iqe4rNfqTJ04k9EUpOyxaeEHnsGdIDFEU3r3XY+Fj5fSjny+DDt1fq7qwTHUsbYoJ/DxvF3N+4rBdG7l7LND5p9+5ymhGnAnkyVDGsNNQaaxP20FPZaTDeGZ548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+uhXyD3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so9237635e9.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727344267; x=1727949067; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxydFIYzjyzIs6vtWvQLyA9LYNvXzxeY7SzWhPDUdiQ=;
        b=d+uhXyD3jlVT4xYVokdNqpIVE50zL+DNU37zXr15N7mcrmAGAcSKCWZJsB0UtBxqWi
         y5X8lI1A7KVhgZBAuKhY7jtgyGq1zzVCvj+1wgZ2gLK5rKzvgPGR3iCFF62pjApiQEBj
         tELULWIKgQjAAz7vXznjCNBXPOMa95lm9QdLzraxui7C2TJeBJNmxQz9Rul1chEABRJD
         cag0o4whTwac7nicNQlq8347Kaj2fv+B0rpsOFLMweRArVdMrJoc7avvLh5YYgu+kWqP
         XPn3lTwV0vnHajXmZ4E8ZLD4jtbFYr90xWLisXeNtpxkd4igezC+qvT7C9bM77xhR3gE
         P8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727344267; x=1727949067;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxydFIYzjyzIs6vtWvQLyA9LYNvXzxeY7SzWhPDUdiQ=;
        b=p3e0ijDNDsw78ch3j5zn/ockst57LxuCxU/r35clU//V2Kg8jOn/r795CW8sfyWqSR
         5fcFyFbekuT74QNgZodGHBKJI5mCCg+wiEzkPedHmOeSFp4T1xjgUFxxBgCub+jnEa9n
         rp+m0Fo97IRotyL5ETO46Rt63+dL0gbQjzA6alHQyTAujMNIpTfCPoC9GP3MPbAIuSmJ
         j/pMsRMJWYHS2RY/Dd4qs0JI8Xhha9YnGMnCtpHOAZ6BEAoR179SSuEVrKGuDM+az6dG
         aMCbqvFkIqTo8lVWan3ZkpA+JHrGK//ore6hbBfyVMMj+3gtrtGHnAkU7ACiCLs/00Mz
         Okkw==
X-Gm-Message-State: AOJu0YyhVhCisWdpGTEd+ZA+2tXhRD9kDw7dtU7ZkiFMs9u77H1dnJTu
	LJuirjVNR9o9AcmZ0mY+zQRsZnO3eifYicJt1gWCGmqc1AT0t6pyBBRliqO/Bww=
X-Google-Smtp-Source: AGHT+IF+YJDQETlp4op/TT8JmztqZVRLewC+nCV2u8xN0PqirWmeh9SX8S+iFXWk4eG308v8VVtpHA==
X-Received: by 2002:a05:600c:46c3:b0:42e:94ff:7ac with SMTP id 5b1f17b1804b1-42e9611d2bemr53364275e9.21.1727344267312;
        Thu, 26 Sep 2024 02:51:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c212csm6004419f8f.40.2024.09.26.02.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:51:06 -0700 (PDT)
Date: Thu, 26 Sep 2024 12:51:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: linux-pm@vger.kernel.org
Subject: [bug report] pmdomain: qcom-cpr: Use scope based of_node_put() to
 simplify code.
Message-ID: <b5ad81cd-fc95-46f3-8878-3ae3765b5c3d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Zhang Zekun,

Commit 181c8148556a ("pmdomain: qcom-cpr: Use scope based
of_node_put() to simplify code.") from Aug 21, 2024 (linux-next),
leads to the following Smatch static checker warning:

	drivers/pmdomain/qcom/cpr.c:1058 cpr_get_opp_hz_for_req()
	error: uninitialized symbol 'rate'.

drivers/pmdomain/qcom/cpr.c
    1036 static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
    1037                                             struct device *cpu_dev)
    1038 {
    1039         struct device_node *ref_np __free(device_node) = NULL;
    1040         struct device_node *desc_np __free(device_node) =
    1041                 dev_pm_opp_of_get_opp_desc_node(cpu_dev);
    1042 
    1043         if (!desc_np)
    1044                 return 0;
    1045 
    1046         ref_np = dev_pm_opp_get_of_node(ref);
    1047         if (!ref_np)
    1048                 return 0;
    1049 
    1050         for_each_available_child_of_node_scoped(desc_np, child_np) {
    1051                 struct device_node *child_req_np __free(device_node) =
    1052                         of_parse_phandle(child_np, "required-opps", 0);
    1053 
    1054                 if (child_req_np == ref_np) {
    1055                         u64 rate;
    1056 
    1057                         of_property_read_u64(child_np, "opp-hz", &rate);
--> 1058                         return (unsigned long) rate;

of_property_read_u64() can fail.  Before rate was initialized to zero.

    1059                 }
    1060         }
    1061 
    1062         return 0;
    1063 }

regards,
dan carpenter

