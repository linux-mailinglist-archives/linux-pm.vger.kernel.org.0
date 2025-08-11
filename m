Return-Path: <linux-pm+bounces-32155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC507B20426
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7865C3BB13E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBEB2DFA38;
	Mon, 11 Aug 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrwLBJ6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D572DF3CF
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905498; cv=none; b=RNstQJdoOLG117U8LFR84Ggd7wQs7fdCy5CZs2omczxCOhv1UbbtMb707lW8tm7WuplXgwWIVzIYkqRVeolsxaAGlay9Xp0GDhWkY3k2IHtFNmPjHmcMBhYsNoBzAqxVwl30TW/IVOtUHG6FPHIArs5FOvdpuREWs5fcMxtDLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905498; c=relaxed/simple;
	bh=oOOiZ1lqQ3eCOyBC4RUT7MgiecSXIg9A00t08CokTII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsdnddwmwGgc/In8NpyPXN/11WmmLM7av6IIwyXpnif21RGFNQDAyTNE/ZZ75ZLp7LijzfRy//Rw4FaO3HRmsRoAHDfps3CFN/kyyAwB0RTzpA67C/3LEaVeHkEhdQHFYOtMjwTUBi2cEBMVK7P004nm+cy2LKpuN0hIhW4S7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZrwLBJ6q; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b422b31b1c0so2500033a12.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754905496; x=1755510296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCoqLwhb4uI1eEgHGHZ1KDRkXmPyMcyy/GtcB68Vpww=;
        b=ZrwLBJ6q7CR54OXI8khFF0A7T9EvvhJqm8bNzTCmHhQxhB5I1RzlII0tr4ntCdXqOT
         AT3/NaTk2MlnB74BaNkVEA3J8v49Q3ArhLAWPIflcd+ddvRHrRNz+22Jeevrqm4No3dl
         //huOxbZ/ZiD0I5pw4ta9kNgVzjXecgTs9qVtdS2KLgEYlEvzghBIIUFTSWkpIeJvxaq
         ZmbMfJP3FAwZBKnCSpM22CpmdTngGgwWyEcLO3BflUjc+X5mAo81X3NAUPK8G5s0IK4S
         ObSN8QVW5oJuJ3tVHCpkeCRJEbs/7AWiGDQM4kGrlLIxUWCdItro3L8dOg3Hy/1021F4
         GXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905496; x=1755510296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCoqLwhb4uI1eEgHGHZ1KDRkXmPyMcyy/GtcB68Vpww=;
        b=Pwbe+9b1WnRINZj56vBfaJ4EiXBOTX8giJyzWgOa8T29ipMINGRHmzabUxk4OFPDok
         XJbDXBvGvTx2uFXjeJb18LIZ7oI9+42ObLWSCmD0/G9WoQbhozJDX2TP4yPjXsTNUttS
         YWjfUYhC8RzZMEqJU1042UUiUFSal3qu7W1ncHuXRy5/8ntt8frX/ThzGCpNz8EvqjaN
         yXJVFSk03+FN1tN66Fu7RAfsa6EdjKDCBK/bl9v8t+XRwBlk6zd//e8ZruAzoTBSnZ0Z
         OemXcWIoKipZJcCHYeAjidHNtq639clBRwHOax7mMvEZudequGMBT7Jf98Ynwd1t9qJy
         o7rw==
X-Forwarded-Encrypted: i=1; AJvYcCX/NZl9r11/Pdlfajnk+sa2l5gtl/kQB0BJaU3+SAMJXpb6IA9PhzlaKBSZ6tetYiXNcb9RjTB/LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybXpE+/j8aeU6tI7Ltc2WLrRVWgg0TMuj8/66bsLfy9x35MCU8
	L4nbau+1/XWc55aY+oXVBA0dZV5qm4M4jLvVhlN5tfBtX/kbBYm/bYEeAm88UMUliiw=
X-Gm-Gg: ASbGncs7Hpy/lkYe/NGjZZHJPj99VeaMeOM428B30VHz9zVr3OL1IG3+KisXq2THYuo
	RvLth+e9emb/D/P+H8NnW8HH4CbGOcLkDsfuZJgsDc0cljSVGk5D5j3iJyhmT36ZjO/2v2N1h1N
	AMs3EHg4RehE/17a69r6kv+RNDmXpmvp+f7VqK8Q+SF4zKKDtIsHerPSCW4rZ2y7gmA0ofy4FSU
	bSN9O6OdaksXTLh/mmyGluSGE+h57ZON1ZhCbGgJQ5PBkx7v+gm8diqcordRTCg54OqvHzSIW/J
	EmyF9ilCMLfbM+0HMw+SBfEt7D1gf4diXcqjcxgdsxQJYTjqKyJfv8V5zfeWAlR7RnhbwkpcpVW
	5yFwOEyFA/oUnssHMb6/qnAb6
X-Google-Smtp-Source: AGHT+IHx6GR2e/+tS4c7qDRjnWjAYpd+pizXL7vvtruA+7iTSso7twvaaA2D0cifsUCnt3e92ef/zA==
X-Received: by 2002:a17:903:292:b0:234:f4da:7eed with SMTP id d9443c01a7336-242c222bf2fmr179458745ad.44.1754905496369;
        Mon, 11 Aug 2025 02:44:56 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a559bdsm15486233a91.1.2025.08.11.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:44:55 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:14:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
	djakov@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
Message-ID: <20250811094453.qvlpwwpmkpdyauzu@vireshk-i7>
References: <20250811090954.2854440-1-quic_varada@quicinc.com>
 <20250811090954.2854440-4-quic_varada@quicinc.com>
 <20250811092202.auarwnyoagebcw3o@vireshk-i7>
 <aJm6ixlMamgX/+bV@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJm6ixlMamgX/+bV@hu-varada-blr.qualcomm.com>

On 11-08-25, 15:10, Varadarajan Narayanan wrote:
> Sorry. Should I send a v8 with this dropped or is it okay?

No need of a resend for now.

-- 
viresh

