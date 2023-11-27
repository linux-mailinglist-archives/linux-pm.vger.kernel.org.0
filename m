Return-Path: <linux-pm+bounces-266-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658DE7FA01E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E328107E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E681DFF2;
	Mon, 27 Nov 2023 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ex208+tl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7D79B
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 04:57:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332d2948170so2870159f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 04:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089870; x=1701694670; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LFzzLLFLjg7KqP8UbUEE/znnYjrA66YoTPzNgjDttaA=;
        b=ex208+tlEh0TPIcWx8OrZCQ9UnJYT27cebYF+slJxj6VOt50rjThlvQ37eUvpXJD8t
         Iodm9/pKErOov4/islDgfVfre9KgUOe4p6DrTSrBA0s8/2duqshpVtRncqXf1FqMFsEW
         4OmN8c4U0ywFB3TUaPriHNg5CqnXA/QnlRx38tq4RLlihnh4okv2R7fS6ZkWFR290tBU
         TNqFIhisbueG8Y2FBb70rtliHkMw9TeqhdNa52RQMot6E5CgJnSxo4wd6bYWdkzKjUbd
         ddOGIiwiZgre48t0GvlWYotABGiUu46CJERKL1YZkpNVBhXG32KnW0CABOx2Y4kKdFEM
         gmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089870; x=1701694670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFzzLLFLjg7KqP8UbUEE/znnYjrA66YoTPzNgjDttaA=;
        b=XYnez/7+gzb/D6ZEcKbGgmMjkadjCR0IDSIDrkTPwpEtiwXF7zx8Uq/ckRd7L6ZnC6
         Jt8fVZrIKrQckjqOPQypBvjRzJ7HIlD/NSoYBlztQ/xb/nPTfnUn3QmP5MCVUq72BmAK
         RD8g7IDgmYhgFAf2sKndM5ZXBnkqcTs3ofRrp825RqaZNdOYSZaRbN6Y1GzKc/s/mhaC
         8GBnc2rXl9aPYE0/m4RFV/dFJBvfCX8eMWlSvlvoM7FXapwsDkSeYWM6d4J6GLa48mKM
         Hb32Qe6b7jB43vCuwz7/gmQTzwVXXiX6QbrmhjYftG8Pa70qa/HCarWPT8YOFcpT3TXi
         3YTA==
X-Gm-Message-State: AOJu0Yyz48/y2OdsT6op6fyxxeAbbpbBgKKFT67FiUEMTMLCVayrvzMo
	ggnETYR0peJxeazm+QWepei3Uw==
X-Google-Smtp-Source: AGHT+IGHISXxOn2WFuV7yY0oQnACtzD8O+LX/3uBuXBd4CccqHeUq5gpG4vUZION9RJ5vPUpQmFb8A==
X-Received: by 2002:adf:f88c:0:b0:319:7c0f:d920 with SMTP id u12-20020adff88c000000b003197c0fd920mr7549817wrp.57.1701089869851;
        Mon, 27 Nov 2023 04:57:49 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d4ad0000000b0032d9f32b96csm11895823wrs.62.2023.11.27.04.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:57:49 -0800 (PST)
Date: Mon, 27 Nov 2023 15:57:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org
Subject: [bug report] OPP: Level zero is valid
Message-ID: <714ec695-0b09-4543-a055-edb6bd9226fe@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Viresh Kumar,

The patch 41907aa4ae37: "OPP: Level zero is valid" from Oct 27, 2023
(linux-next), leads to the following Smatch static checker warning:

	drivers/opp/core.c:815 dev_pm_opp_find_level_ceil()
	error: 'opp' dereferencing possible ERR_PTR()

drivers/opp/core.c
    805                                               unsigned int *level)
    806 {
    807         unsigned long temp = *level;
    808         struct dev_pm_opp *opp;
    809 
    810         opp = _find_key_ceil(dev, &temp, 0, true, _read_level, NULL);
    811 
    812         /* False match */
    813         if (temp == OPP_LEVEL_UNSET) {
    814                 dev_err(dev, "%s: OPP levels aren't available\n", __func__);
--> 815                 dev_pm_opp_put(opp);
                                       ^^^
_find_key_ceil() can return error pointers.

    816                 return ERR_PTR(-ENODEV);
    817         }
    818 
    819         *level = temp;
    820         return opp;
    821 }

regards,
dan carpenter

