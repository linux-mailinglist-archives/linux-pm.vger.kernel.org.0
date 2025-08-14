Return-Path: <linux-pm+bounces-32386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F37B26051
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0619581277
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66C52FD7C7;
	Thu, 14 Aug 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ga0R+raU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6318A2FD7C3
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162128; cv=none; b=T3fhCVd7Wi0PzrpUnoQ1nZvJeRstF55/S4ln2yzHR/pYQ+vxoKi1ISny5CoyNTjbcEKNCW63j048CTI+iCkGrfZFF6zzFewpu0Gjjh9w8b8Jo5VVGu76LaSNXEHuixu3vxwOdy6Xis1oCWBOiKA1iyD8qr8eEDLeUXJATNkvuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162128; c=relaxed/simple;
	bh=VIgbe0+cTepm+GSjli9I/liq5c/PTGeriBLsEt/LdqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLfW0KLBAHM3P2CbYc5S5C4qbooiCQ111waKI/vgeWIvcZuGTDTvuMeDydi8BPsWCipdnk+lD7e3I7P3lgumZJBdXxSmO/hjBrueD0LTFF4yEYdy0ZU+xas0tT/O66PL+IlzQ2fKuea+wFjB1uATu/MqE5cVtG2H3H9FZnrKDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ga0R+raU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb2bf30so810626b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755162125; x=1755766925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmE7sMJ+PeGcKylBDWZA2ZrG6ibfGIlvX91c1+5XOpM=;
        b=Ga0R+raUBTTsNApohCfDOCCWUfezgcO/PQ5UxptTU1TmqZNTXGsqHG4Oia1Y9QQaiB
         Gs6IgmVVbl0bxPl4NW0D3pfXmbGmvubjCN8lp2OIjcsjPASZ63YrJN47vsx8gcduSvNJ
         FkBeavNwr3Mq9Uq/OSNS7jboHs+IwMF38BulSMSgg9lKd5VEINo7/nlg4SUk3iHj31do
         wXmtwMKPLqb/fH173vX7VcMGnVmqy1n3tc7WQfsOh88D4Byi6LkBGvsA3cJb37q3vUKI
         82HXls4uXjV/F19WGXs/ZhmR+DevNx7rgMlAbLnggYhuuH+mGHfXiDrfoTPOfryTiBPN
         XQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162125; x=1755766925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmE7sMJ+PeGcKylBDWZA2ZrG6ibfGIlvX91c1+5XOpM=;
        b=n/ePnwnNQsIAzaJBV3jXkjuB/M7XI31C+eAqmAh46N9DMkondbygHRRyOhhT71DM8j
         xtdQ+zSANLTSk6TaMTHpZVYu202EI/mHXGQg25XuRLDJnez3e21A8mcE+DKua08fhNL6
         8Wgh31JjnUWmUETa/dF23hB7j7jmpkUr/QRGlXLtuwJHffgWjOOiyTf/dCNnM0ok2WJS
         GGEMrs+auPtT9IrS9AwNdHO23y+ChPDvACJDgcSyWSaCF501FsVi3PWF5m4Rbfw3JPNS
         C/mzLbzPEfqn3SdhXpVat2I/+sq7pezK0WDdPpwCd24rA6SHFha43YOHiWsTMz2Iu49h
         mNVg==
X-Forwarded-Encrypted: i=1; AJvYcCWpc85gNKM82fGAj2e3CezkEvXsY2XYKklXZXrdEkx7k31qCa8qMQc0FrUaoy2B4He0cvXbNHFoIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2F9AZbF6q6SZJJurTJbqAl+5ZbMo5yuHEWkQ+K2aLDC1ye09
	oLzYGaFdjbNFsBLnMSZaaw446Kb0W5Uji79v+mLlqBJivQf7Hpnt3q7MLBbfNM6rDzU=
X-Gm-Gg: ASbGnctuOYFVwJiKXXgWJu8e3O5S6IcK7IGzBNZn+zwEU6wVPOSNvqU064ebNVxLA3v
	ziG0IyoqjZeapbQGjXce5InjEDXe2ra2/imhOJ/vp3qQAqN7bfmbtSjkWXQNSBCZ54GgSejOeIB
	Y8ltkm6o88kvMZu72JZ4UtpZWMENG8A8iiV94Wmqihk5I4RzyvApMB44bEpM/QL+RjLXMm+7JS/
	VBOrt0xszDORUb9lepelf6lZZ4bzHw56uTET/g8f+SuauLxJBdDIUeMMEp0dIFdbZPDluWPZShp
	UqXNDoXcLDhK6dFzxYev7HRsI9kK6jtez7CTNkgds4zz/BKqXcy5PAyVv0Y9rV1MJoWb8f/Ml8K
	GPerx+03w7yAGgmPw/wCJn2GOPbW/NsSOpZE=
X-Google-Smtp-Source: AGHT+IEFfT6WjP2Xn7bRIAeP6rPkcMNitalN7pBUBi2AiqkDrDv7x4NjeKEEWrLKN8kwbYf06w6yRw==
X-Received: by 2002:a17:903:2a86:b0:240:80f:228e with SMTP id d9443c01a7336-244586ff5b1mr32099585ad.52.1755162125651;
        Thu, 14 Aug 2025 02:02:05 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm350103075ad.159.2025.08.14.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:02:03 -0700 (PDT)
Date: Thu, 14 Aug 2025 14:32:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Return current frequency when frequency
 table is unavailable
Message-ID: <20250814090201.pdtvxqq3st65iooq@vireshk-i7>
References: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814085216.358207-1-zhangzihuan@kylinos.cn>

On 14-08-25, 16:52, Zihuan Zhang wrote:
> In cases where the CPU frequency table (freq_table) is not available,
> the __resolve_freq() function will now return the current frequency
> (policy->cur) instead of the requested target frequency. This ensures
> that the system doesn't return an invalid or uninitialized frequency
> value when frequency scaling is not supported or not initialized.
> 
> This change improves the stability of the frequency scaling logic when
> the CPU frequency table is not populated, preventing errors related
> to unavailable frequency tables.

Is there a real problem you are facing ? Or a code that path can do
some harm ? I think this patch may end up breaking users.

-- 
viresh

