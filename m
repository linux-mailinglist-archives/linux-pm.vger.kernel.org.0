Return-Path: <linux-pm+bounces-32390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B843B26134
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 11:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C31C22AE4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2363074B5;
	Thu, 14 Aug 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0uvATVe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D393074A6
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163915; cv=none; b=Og2+MkjQKiz8IVsTxjvUrxYUszFFuoNMVMhLDXDXmrSn5h2eV42Sx10RDDaMEc8nGS6M61zovB2Ha0wrLh0fIH4I0ZviVt9cuhpJDRjIZk3KhNCxmrFIs1Qf5IL0oNdnttwHTHM5Qbd1VWlTym70/YqS+8xvtA2f2toRHLT3Yds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163915; c=relaxed/simple;
	bh=fijvh1Io+D01e7vlvgm9vHdhu9F1/ZeWvTBFZGxfd8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X94eIcqDAYy8NZvokM+OIxsoduwJEpiZmpZzON1n8jvCRkn5KtchSkYcTVySd8u1Uxwe3KlU7T443w/C1dhV7N0BG0WktmEUdooy3XFHkSc7lfY+fyNeY8kXXls4mGF2Id4i7ctDthjZ6nsZwCLG5bFMSRAZd3RouPOSlKqanvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0uvATVe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso574448b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163913; x=1755768713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJQjTQPOVmlrRZrnxoAqufcGLuagbkJPkwYuRKf3anU=;
        b=d0uvATVeqF6vwiqqCPkDaIZtCRC0GSN3BebyMOY1eBZgdQSqyevGc48t+Ru7YHeEPB
         OEzsMqcGeIM16BIBswY+v1nQfHma0NsnvgSufhGht1/7Qy8rXW1tltuzTV7NaHC7RUdz
         GX2uZrf+JS7y3GXMJZgm1X6GgFtcZSAd7DoSTUcKsc/o3W1LOTpwttJnuLG4S1UxY1lT
         0m5brhNNwVCOiMJTjrXeNwEsdHukdUNjj8JpBSV8q5TltdFKBdWByPFAb3FLflXLQhgQ
         5GwN6KsALz2jm+2VGh9wvgkfOybllZGZaLvuORMPMyulqf3D4prrBq+V0N/engKfS+8w
         j4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163913; x=1755768713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJQjTQPOVmlrRZrnxoAqufcGLuagbkJPkwYuRKf3anU=;
        b=ht5cSVsjk0mb6PRfimksSd6JC9on6fbW36BCcWI57BiBY7eJUe6OiB0qy44dgY6aPX
         WFNtmGATfyT7C2KvBSknWTM+aXe7WrxHPOvBUj+2pmEPEph/jwiSBd5EBPUe8ZahmfTE
         o7Y7/+hfpJ8Y5O0sywwWwEWbroujZnK0/CndgwuC46Y9WHXAueaKLGhG0OPp7kPyzmgx
         6QYLb56TGJd6Eo0Pqjv8Ut8I1rt7fXI5jP5ogf7wL+k0i45NGpyfzbtP9pC8X9ttP/rP
         jLphC5YdzJSQ+3u6wkjpI7PWd5yqGK+8Ou1QdX4M3vx9r0F5PzK+pC294VupsQRGOufg
         fsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVPusoqOEjq0nusu0I6Vm1/3J6NJ+YGAh91+/+wGV4elwSy531CXxYhtNT3U5B4L8d+Tv8BhyPxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyouncNz2wNL64aH+/p22uKBQiOiW2ckWUhyituFI7Dml0dzMHU
	ZnMYee5OO+XahFPG0kIIRIJ7lE2H/u1oruqNbC0ysJT1bJaRy5vjta28+tJWnZ3yDO0=
X-Gm-Gg: ASbGnctGNh1dWrcKmIoYS9nDAZ7CjxLwwkNcn4/g4R9DxZ1TfArkvTIxAi66bbk/99Q
	FFex3EFNAXcrMO1+i02tmF47XnTfMMBa+oUfrj7jX+0gVz8YKGdU5AF6SYd5cn3ogw6L3gybp6D
	ToRH7zeztsJkxCk8d/sN7iSu9QG1Gr5CoA142UDa8Xd9eOJE/0iH0uqLpeQnlcIgh2rsGzFbHPD
	tMuCehVYTNkrSCg76LiFkb3CjMczQiphiilDA2W9D9XZzqvTnGQSGU9oiylvW07jj/F0uqDwN8r
	j4hc/a+c8PIRTcP7EUkYWCzPjChASakWiVUmRF3i46SSIP2j5eWx1XZSvQzFJ8XpIL5xySR9QHM
	t3QSNXG6dyggPdEsZSCCzeFbO
X-Google-Smtp-Source: AGHT+IGt+a3zic40FsS4GaqjDHI71oyeZLUh6BKu1SRmqo/xOps+14RtHTg7s8vjxpDcoyfKt36llw==
X-Received: by 2002:a05:6a00:2196:b0:76b:fe65:71f5 with SMTP id d2e1a72fcca58-76e31ff2ae2mr3142286b3a.20.1755163912683;
        Thu, 14 Aug 2025 02:31:52 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce93da5sm33802268b3a.50.2025.08.14.02.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:31:52 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:01:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: Return current frequency when frequency
 table is unavailable
Message-ID: <20250814093149.ob36l2gxo33snbac@vireshk-i7>
References: <20250814085216.358207-1-zhangzihuan@kylinos.cn>
 <20250814090201.pdtvxqq3st65iooq@vireshk-i7>
 <3f901678-c75e-48ac-985a-2834f9ba4c8f@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f901678-c75e-48ac-985a-2834f9ba4c8f@kylinos.cn>

On 14-08-25, 17:24, Zihuan Zhang wrote:
> I just feel that it might not be ideal to set a frequency when the frequency
> table is unavailable.
> 
> Perhaps adding a log or warning when the frequency table is missing could be
> a better approach.

There are a lot of drivers that don't provide a frequency table, i.e.
drivers with setpolicy() or target() callbacks. Only the
target_index() ones provide a freq table.

-- 
viresh

