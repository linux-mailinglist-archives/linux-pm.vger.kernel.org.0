Return-Path: <linux-pm+bounces-33094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043FB356CC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E15E1890810
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F52F99BD;
	Tue, 26 Aug 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR/wCl6v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC274288C1E
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196827; cv=none; b=T6afCGCZ2fpg5zWexAm4YduYC95cNBVEay49EecjbTRo6VMaACuQhcb1svUBs9wN+p1QvmGoOdahWUQVFTnQBtnseAR1NcfYxsoqvAJppJat7fcFZqa2JgFDUIn+/mtpjiY4oUKphpy2U2hWQbaR05v6QWt5VsTlk6SomYa4BDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196827; c=relaxed/simple;
	bh=CmOw9MM62MUmPOH9GRufRxbgMIWxnIxG8qJRDX5brlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJw8EuZwfsJiCenz2+bcNzNYH09GZ4m7JMXY8YFcBfqEUa/bN9N0bs9LZXKJRkZq/dmYBUtHvj5ZpVg+xF0e6pPvUOYj4s83sBZKFNdNxA2QwCcMk0y9dq1gUmDCxneDFR9qB6MBAlKDTcLY73nwKKUQhBV96YsouFFzjB2+sL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SR/wCl6v; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49d6f8f347so2285316a12.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756196824; x=1756801624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VltlVNdXca1d/9EeoyeMXnoTiPVWJrYRgV1MAzlI0fQ=;
        b=SR/wCl6v2M7KXdsxchwPb1r6tpsOusoiJk7yPEzIw4pcdR3K/2NdcMpyNyrYgSdSB/
         Hf0j5sHxXtLBwI+4aZqOUqLjv2fKE5WJ6YnUi2Y2aEs/SzzeupKP+eLD2c+Cuz8+ODDb
         EP/Ki4RqhGkzLtBPURANsVXZ3mF1eHN3oVchtlVmJudKiP7yC/JE9IK3aQR7/EbgvSBY
         v5PUnDdVVBtcZQv376MXELz/9LklRqvm1CUK1IfSy2IqnUxQYkbmwaREKns9G6B920G7
         FWyCg1SaTAa7wE4IzctfZadTn8Rap6qGLQ/v4Y6wn5oFsS7k9CChQpUkb5BWe4zQf9Cu
         gb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196824; x=1756801624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VltlVNdXca1d/9EeoyeMXnoTiPVWJrYRgV1MAzlI0fQ=;
        b=BMZYFzAahH0psp+YBMm3ZuSIFNp+8iz7tlpK7x2JEPcD7g7wjaKzIverYBk45oF4lz
         psSIdOCkmGq8aoRz/K60UmrYM97oxmYzWyHY5Rrj3cMdauw0f9XIEU2YroW6NrLVTwK0
         JGgOxNQFw7D501okHDR1jCrqF1DtwuPf16FV/aNA8vsQijJ78reTapIsD4ToSB0d6SBa
         e+DS+Nm6bCGCsTabCrPrWyu5OPHMdyyxiOcpPsmG6BXGdFL2byICK4/1ExSydZcPKHdQ
         YFON10AZ2PH4NHT9GLxGKB7ke8O/ueFyKOZ9nlCzYKAxU79AsMdn86mUryjqMtt7NWWP
         afoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOuuXm9T2Hb1Z7ITTBckgjMTeMuTFYmwTuU5wy+EmG3S4vPYVk+C4rRrdjSa6QgxMRrCHk2a3H9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgFQwKA/m2laeP1cKNjewfC4AJDkLIpSpyUEW1tNZPsktdCvy
	WAcpySa69Ziqd4NmU30MgZEzhq1zKIUljExCn9T7GdH7WFOxtDzhm2o7EblvaVcx5j4=
X-Gm-Gg: ASbGncu1O1mgieE3CC90xav1DbikPK2ohFKHWn3mDY6VKGi07Z88LtgZQEb/njnyUE3
	Pot5rLyW7N4iiAp5dJx2NqFjnxk88MkRC31bX5SL/T5gQjVgVh1AajRwZr/QkNKZfl3lNZTSWgZ
	HsgMpGtf2Mt1pwpoh0byZXTd3RBldwxxqQEFdrcVgkzbVTL+x/2b+RzBTGdd4BPdx9yQa2LzKdE
	T6SggWfetrQ3iJhENhTnSzOx11b1WVDdo4q1YJGJbuVja1r7jQcBVJoShvpZXrtHSUbjAzabhcL
	oHnYGkeZsduHWSh6HcUOaKNXW2+Nx+p/x7XH2PeN+D1kAwslOtbT2C4+BMHM35Mu5DrufsroO62
	XXn0SUuPmde9qHd9d3wKQDPDi
X-Google-Smtp-Source: AGHT+IECSU/SDSD+0Cr5TrycnubLdgbitEMB4/KAzano/y2obaZMbKPJEOdIDdWn74RnHNtuJKk8kA==
X-Received: by 2002:a17:903:1b65:b0:246:b1fd:2968 with SMTP id d9443c01a7336-246b1fd2ab8mr81877715ad.9.1756196824113;
        Tue, 26 Aug 2025 01:27:04 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm89224405ad.122.2025.08.26.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:27:03 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:57:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250826082701.tv56zzg2hdavy6lq@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
 <20250826052057.lkfvc5njhape56me@vireshk-i7>
 <20250826053606.zktmwgfdwymizv6k@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826053606.zktmwgfdwymizv6k@vireshk-i7>

On 26-08-25, 11:06, Viresh Kumar wrote:
> Can you help me testing this over your failing branch please ?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 81fb7dd7f323..5b24255733b5 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>         list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>                 if (temp_opp->available == available) {
>                         if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
> -                               *key = read(opp, index);
> -
> -                               /* Increment the reference count of OPP */
> -                               dev_pm_opp_get(opp);
> +                               if (!IS_ERR(opp)) {
> +                                       *key = read(opp, index);
> +                                       dev_pm_opp_get(opp);
> +                               }

There are other issues too, dropping the patch. Thanks.

-- 
viresh

