Return-Path: <linux-pm+bounces-6294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6408A25F7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 07:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB391C21585
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCB01BDDF;
	Fri, 12 Apr 2024 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVCHuWZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A12224E8
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901069; cv=none; b=lvkW6/xIan/jgMoaHwZTXWH3ZIwjCzN2yXQ/9ibrcgx+6NRdPWpGhdB21UU9c9y+0ahrs8mgo7GkoUk6vFAiDlcjsJIfkHn0zGQc0KOhY6+EyleT5EoJ5BAS3/srXhBKFXTCW3LcfWXSKeIudPdL4ljY/WO6wVlzDelFYBGAnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901069; c=relaxed/simple;
	bh=E2HOYIo0M+louxFAZIYoIGaiArPc5YQLoHHmYSX2FfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIzCJmIV9fOGoOi/NTyD6h+VgwDPI6m+A2O8P+s/gWZrZmD4o5EoCUYRC/rVL3hFAKpLJk/FBVQ786YPsjB5iVniLvEnOTUjzOhL7H2IY99rKCcBV+5CwOmzyqltUEQNRU7LoKcyn59T9RWs3xsCRMHOVoa+wHU5yMyG+7jmRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVCHuWZK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa22ebd048so423030eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712901067; x=1713505867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsq5q5UHoVt7pKRebObRPtr1OCda190s+OuGBgKxHn0=;
        b=cVCHuWZKEnfNt4Bq5y81P2nYkhOngE0auqOb23OMyApnZ+fEUl1iHyHJySur67b4R4
         urob6A9rH//4KGHPD3TbwFTiKEBLdT6V6PJxIl6OjyCvq9b0uRdXLVFc6Vyis47cn13+
         Ztak1W9skJyPx3HZhf/BPloRXdP8e3Jo+IEth7LqQ38uDydAQ82cWm8H9WlmJZyopWiD
         l1UAvtNbMuzQjHYlE7tH2n7AVzHwBN5EnQI4VsZ/aSJKgMS7U9NcKg5rwUEmd193858z
         OebxWqXUBPes/r74sj2hCwKonlT9zauWBksy9dVVsyEJgrhzAjA2VELbHzrdWbFvMNN0
         m/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712901067; x=1713505867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsq5q5UHoVt7pKRebObRPtr1OCda190s+OuGBgKxHn0=;
        b=FoPNlMR94jcUEDS5y/QR80kbwHvX4kKq7viyUo9FR6leUbK7BAY2EWBDM5CXNbipzd
         UE1N/LaP77hKv8MQtsDm5rISEHcqoozOignZwfBC5OsROU0YhyncvRVRm5waZ4/KCoBc
         gT/F9nmODwu7JsQEszX5cjwHfOU2mS7WFeUPIi/NZ1TpnSCe2HJIZYSPdlF8ViOi05ae
         p193VlBosO/OMgJeyFDpz6q4ylmo68nmwOPX2BaoJhfAylU+/7UaeLTUOOf3XkYFxHiq
         U3nxXh6aaCfNo9P//0b9c5DsOTi1IrlA4zRWdun45VK7HzDDTI3NSAD2Ldusnq0WZRnF
         2MSA==
X-Forwarded-Encrypted: i=1; AJvYcCWz7fKXiAb3pahppA5k37XZbqcxlM7ATInOHBF3VS7Y8IN/hON518R3UbdfTvkl//4iUEaULtjcn4EDcRSZIFrUktpfKkIWGVs=
X-Gm-Message-State: AOJu0Yx78bdwSZs7cJHu5FIgX6dGqAeioBb/sg2wnNGQFz0z9ON2K3Sz
	JUQHgL2G13gxwOiKIejLbLn0OWEu6cgSJZq5xdNFe+JoAmGkpfl6vUh7188SIlw=
X-Google-Smtp-Source: AGHT+IEG1FU24MtDCXRG9NUIv3wHELsdindXw8+i8hpMtR3KeQx//WqcDN2bTFHDAFA+yErzH/gw4Q==
X-Received: by 2002:a05:6870:fba5:b0:22e:f3cd:b6b7 with SMTP id kv37-20020a056870fba500b0022ef3cdb6b7mr1845728oab.27.1712901067103;
        Thu, 11 Apr 2024 22:51:07 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id gj4-20020a056a00840400b006ed92b011desm2089319pfb.169.2024.04.11.22.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:51:06 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:21:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: lizhe <sensor1010@163.com>
Cc: "christophe.leroy" <christophe.leroy@csgroup.eu>,
	mpe <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>,
	"aneesh.kumar" <aneesh.kumar@kernel.org>,
	"naveen.n.rao" <naveen.n.rao@linux.ibm.com>,
	rafael <rafael@kernel.org>, andersson <andersson@kernel.org>,
	"konrad.dybcio" <konrad.dybcio@linaro.org>,
	"sudeep.holla" <sudeep.holla@arm.com>,
	"cristian.marussi" <cristian.marussi@arm.com>,
	"thierry.reding" <thierry.reding@gmail.com>,
	jonathanh <jonathanh@nvidia.com>,
	inuxppc-dev <inuxppc-dev@lists.ozlabs.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Convert to exit callback returning void
Message-ID: <20240412055104.y5kea33qsvxbywg2@vireshk-i7>
References: <20240409145316.5181-1-sensor1010@163.com>
 <7abe982f-54cc-4288-a410-df43cec68f67@csgroup.eu>
 <6dd5eb5.28532.18ec3682dcf.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd5eb5.28532.18ec3682dcf.Coremail.sensor1010@163.com>

On 09-04-24, 23:09, lizhe wrote:
> it  is  imperative to modify the declaration,
> i have not completed the  submission yet, only  part of the modifcation have been submittef

Please only submit patches after they are fully done. There is no hurry and
sending partially prepared patches is only going to waste everyone's time.

Thanks.

-- 
viresh

