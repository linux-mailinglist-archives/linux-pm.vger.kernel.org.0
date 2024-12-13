Return-Path: <linux-pm+bounces-19170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FCC9F0353
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 05:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D93F188A93A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6E1547F5;
	Fri, 13 Dec 2024 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6YAOvUG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B116EB54
	for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062406; cv=none; b=m79gohDYaiiu5X8hhZdZxqorz25PbgNXZ4cTlb2ty5DWoqhwTh6JPi45m+fklr4/+wwdqU81Tjmi9UznsqyhPO1PzSReVgh8Itei9KAi48x0Rt7JxOvmSkq2cAEb8mO3CiRsZoag8thuH+JhPNmnIF0ZjII4QSY6gJcsKtZBlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062406; c=relaxed/simple;
	bh=P01/0GoHPmuEpkWAv0N7wro68NmfQGGEanTXYNwOczo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgS5rJpVWCEj5tFuU8uBITCk1TwemIsICcSWHGg0NJ1aiuubghABdgZol/cbjkt7Nv2kjbEkuqsmpIKhDgqzmcxoERAe7WkgZyy3kPl9sr0OxiNv7Tk3XJQlXMIQcvaM5oloeSMG3a0pNFA61nGLkUU1C4kc5FUCQtsbnegAGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d6YAOvUG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728e1799d95so1534000b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 20:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734062404; x=1734667204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhXht5TlWW6CeNHzuz55gp9axLJIkTvb4c0JWEpQZMs=;
        b=d6YAOvUGswYQvn4sx5Xzz409DT3A9wRiFs7hyXls7RKX/b0iQbSHVgA9tX5ySaYWO2
         F+xWn7L3KsxniE4JxmQsnfuT8+6vf1d7RKsieUVvMmtbHuTSKxS7P+3yESyJcA2Y75ku
         JLICNjK/FyPPFubP5H7I+LtI4AK65nJTo348m+jeAjFY330orOai9zStDF7JNFpKgSFD
         ocYb7SeuF3E//wbCEwi1TvVygtE0mMNsJ1k068W199B6HiKCym1oH8Su0d2i0QFrCQqg
         x1bGiSYZ8hEJnXF3R7swvAAF/fofDznrfJm5NauHIN7UL47J9ydSVrUbtLqdCxRMmtjF
         nXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062404; x=1734667204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhXht5TlWW6CeNHzuz55gp9axLJIkTvb4c0JWEpQZMs=;
        b=QZbhIP1NP+gWX059+Y484lfjSE2cEJt4n8TujkkeOmeGO73Wq7U315PDTi2Zdzhwkb
         NCiDoNcU7GBVjeM6RGzofoN3wRFl0236ABO5O06vIFk2x+d8294FyeUBtFp0SRZRQgfO
         q1WMycp0WLoVPqjT2hQ6Kc8cT+K9lafX38v7UKmQ1ZfflS6NifMA6u98P5JYBIwEz7u9
         ZpWpOvDzWr4ggRXo2pMc/oWzvTA1GY16JitIegC9CZ5VGFUIDNjcD5ip9yk0FNIkZ38Z
         6KE6JRN2ez7wBwRaDnK26FOFWVg8i9u2xoeUT6szTjphnNVtyt7CHSeJrJnc6DSYage8
         h9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUEuROtuMhl25zPINqZ1BF8WS0BGWIw9I6C0zCvlAyP1PQt9jv9CZWl4WRZLVV9FOtOEex2HRkXZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRGuX8ICNEIyylrIpXYwn3BkiC8+O3kVTmQH/Nnc0Fv5KsJDc
	ALeafzwdxDnVo44iaKL4rn1/g0v6hdd2wRUWvwcidIjFYQEtSmWRvQRJXiosuyk=
X-Gm-Gg: ASbGncv1jH3Y/3c3Cf2kwbWDs7JYaQEzw+8GEcr6l4k18AeSYa7rfDDE7SKAiBgDIT0
	Q7aWjupRXU+uY7xGWk8Cl9eUl0BZS0ooBwe2WbaIROnapkiMUUt1hsW93s3gYnu4LWVaTKvLQR9
	pZ8JQmYvlyqYJEuRfMgXl7pqRWcVnA7gjuXGpr1AjCqPbVaWDxWZr7htX/8sRbqtrCcSJm3wlXs
	PoDWl3QX2K2j5rx26Tn3Do6JsCrk5Er4WXupkpijXMFCIyLAdu38m0P36s=
X-Google-Smtp-Source: AGHT+IEGiBKnjCtShkOggoGzo2ZF1oEbdV6d4yrpPr5N759VcuXFZHM+wVdwNBDeb1V2E/ylIgRB0A==
X-Received: by 2002:a05:6a00:1885:b0:725:eb85:f7f7 with SMTP id d2e1a72fcca58-7290c0dfe03mr1559884b3a.5.1734062404251;
        Thu, 12 Dec 2024 20:00:04 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725de3cb93dsm9438945b3a.169.2024.12.12.20.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:00:03 -0800 (PST)
Date: Fri, 13 Dec 2024 09:30:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
 <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>

On 12-12-24, 13:01, Ulf Hansson wrote:
> On Fri, 6 Dec 2024 at 22:16, Christian Marangi <ansuelsmth@gmail.com> wrote:
> Hmm, it looks like this needs to be moved and possibly split up.
> 
> The provider part (for the clock and power-domain) belongs in
> /drivers/pmdomain/*, along with the other power-domain providers.
> 
> Other than that, I was really expecting the cpufreq-dt to take care of the rest.
> 
> To me, the above code belongs in a power-domain provider driver. While
> the below should be taken care of in cpufreq-dt, except for the device
> registration of the cpufreq-dt device, I guess.
> 
> Viresh, what's your view on this?

Sure, no issues.. These are all cpufreq related, but don't necessarily belong in
the cpufreq directory.

-- 
viresh

