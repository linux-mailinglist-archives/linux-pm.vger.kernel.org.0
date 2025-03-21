Return-Path: <linux-pm+bounces-24365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C820EA6B438
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 07:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7C17A419E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9EC1E376E;
	Fri, 21 Mar 2025 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qd8dj05E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3731C5F1B
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536913; cv=none; b=O5LI7JkQlL0hiViNAl6f20LEhls2TbA3PX6ruBuUnzbEN6NK0o5njY8R3+X3xdOEOE245Bkkwc3dI6yKefPtrxrp99USulzpGI63DrOUWSiVM3FhKYRbznbGG3u3vcOvkFHsPqZqeqSNsghpJInZIj1j5wB8UtKKYcfh8/J+5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536913; c=relaxed/simple;
	bh=+RAqoCETRsOOC9URTvVVr4hpHwTaKDmnHI/bW0iosXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2FOcTpQXImNDdCmH3kC3Q5dkBGAIu0XC9UYqSqthuCpn+VTXVxYiAIniECp9TUyVSSDyhfIhmvpmipOC7EZWvJtd5saH5TtKSvrTsAq++plJCZzOf5/gFIQ5SdW/mzx+JhOv09Au6lBdG6lVRni0OxigBKIGOzcRgslWHudlIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qd8dj05E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso26700635ad.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2025 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742536911; x=1743141711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmB3zEarsAJrwCcZCi/AJVx4uS/XYfMGLk5IAPZ3kC0=;
        b=qd8dj05EbFr4OG29YIQKkXgH6/f2fX4oJrCVT/BNMVCcnSvnCuCscQhBcDQm901f3Q
         RQChsPsa+YDKj2jlC5enGJ3/HQUVgyy4yoq4UqRJ7IPretxJ9E7hXCZVinudbyX4o79X
         M25+MlbwHsHpHtwuyI29sB7WhcYox7++oxqApjW5+NWWeAr1Z5qFJGAZPpqc8HuqAfyN
         cFTyGZDVWMY7dIl1fx3VusTBqr8VT42kEWfNOVlqF48QO9y6vxTw9YRTEEd93kaqBMeq
         p7PCKfLVvsbx6/Nyc15y1oFen57pEnw4S5o9mJHF3kQUT1dn4wQRoFFr0doz6tVk9fGl
         ZdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742536911; x=1743141711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmB3zEarsAJrwCcZCi/AJVx4uS/XYfMGLk5IAPZ3kC0=;
        b=NFjOcDeTqH1nYcMkpa2v2xt3EFC9JoL/1sH8wC0AT/1a5BDUMUbhdb+NzQ5ERz0mAe
         2EVrTsj3bW4/v91dytGIMMXo5FibxoxfkMUw53o7jPKLuRgFkjxMliG5HSJvcWKbGH6u
         sUQYS26N53SUDsyNdELQexitC+avLxp3FgrQgsz0cGGHhtMn5mVhjJJKEjySo1G1A6H3
         DBrjIVPb2DQAwW/98pyHKy03sZEyLHe0dGXFkyYE588zaEsFlBwpEz0qPZwp6FyOwA52
         +gT/pl2VexcndBtUxgaGVEpl+bOhdo9k54xxRePYgXtqSCKBEV+5P5RpGXGF3FyRGdI2
         Zy2A==
X-Forwarded-Encrypted: i=1; AJvYcCX5qvaxP3zGzrUDqWfLy+OFMJQ5YUgbXIfSwiAxzt0vJf25WoYAjLGIrJdo/zrx2X565/XbfDb7NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkEa+W18sTLBuUg/IdDgU288anXXbDlF1a03SzvMKX3VNNLaG
	AhG/KwKJrHzj8kNUiCdAUaMDCIYnso3nHoqqtWtxheTg3qqnni/XEtEhjMktB+c=
X-Gm-Gg: ASbGncvdVBHCsbFzEwjKqTBqn1eov8o+hjDzcdKSpskwxzdFk5h2+wjT6bO9EyNRS3S
	suLhjlfq/f3+did/RXej1au/5D23riSemuEhoTOBpo9r9I6s1BXhTdm1PAamhfFqZzEzYeDo/3v
	anXpmK/oZJsc89UZUf+XR+hNBbayh77BuF/VgczDP1KK0prVZCOWyCtswy6fgge+rYERRWMR9LQ
	o6lumLYFHTTpwRWOEZBJRPRO2zXe7l7kZ+nSyKb/vFV6VcCwNm4H90KEWbotmLrpAgpR5KACz+D
	3bDpXHkKXmU9s/GyQVA0aPxyeNu0UIFEFl8mZi8loCsALp17iYfNOX28
X-Google-Smtp-Source: AGHT+IFtVqF1ORKmDSsfR3TArM9faGSxKWG+5TBHlY+RPgM/7ilFPFIlu4kDkXwHLe/srNdTiQnoFw==
X-Received: by 2002:a17:902:ceca:b0:215:58be:334e with SMTP id d9443c01a7336-227806b8e47mr42530375ad.10.1742536911081;
        Thu, 20 Mar 2025 23:01:51 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da89csm8204645ad.193.2025.03.20.23.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 23:01:50 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:31:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Chun-Jen Tseng =?utf-8?B?KOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>
Cc: "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race
 condition
Message-ID: <20250321060148.adhxjexpnm4dkpnt@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com>
 <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7>
 <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>

On 21-03-25, 05:32, Chun-Jen Tseng (曾俊仁) wrote:
> I add a global lock related to the CCI driver.
> 
> This is because the CCI needs to obtain the frequencies of policy-0 and
> policy-6 to determine its own frequency.
> 
> If policy-0 and policy-6 are set simultaneously, it may cause the CCI
> to select the wrong frequency.
> 
> Therefore, I hope to change the setting flow to the following:
>    policy-0 or policy-6 -> set frequency -> CCI receives notification -
> set CCI frequency

Can you please point to the code where this race exists ? I am not
sure I fully understand it as of now. If the race is present in
another driver, CCI ?, then shouldn't it be fixed there instead ?

-- 
viresh

