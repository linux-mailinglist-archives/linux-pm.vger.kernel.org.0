Return-Path: <linux-pm+bounces-33604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD6B3F562
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C552482255
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9D2E36F4;
	Tue,  2 Sep 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGrZfnDt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9542E3373
	for <linux-pm@vger.kernel.org>; Tue,  2 Sep 2025 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794234; cv=none; b=hvRBZMpIroAbg1wqkySe3H+d74WX0XcjIs3s6uEbI8YXPvql7AjNLU2L63B3DL1OzpJnYYtRH+ibhrc+qQhDXcPySqL0qeILXmCRSRj4G/J4ZmUWpMz4gCv0hWMNWp20wBVooXBx/XHBfTs5zap4khMFIbhQTcW1ZID4plPMric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794234; c=relaxed/simple;
	bh=BfMqR1lpaXjunNeu/f0O3MEaWJtI9f+ZecBRwP2xSJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDvovciDpCa5aH3jmavhGgNIn/gmW3+d5UWYb4xoOx1bgYEIsfVnQfbr0h5GFzmXqkAlWZZp5Uej0vnnEm6nbaNCbVu1J1eOWruQwMY2UmEKyA653B4yPXbJJx0F0utFXn/ZU0iVBNKI9qsFt18AHbrSU5AVbPGHE7T9Sngwj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lGrZfnDt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-248cb0b37dfso46356585ad.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Sep 2025 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756794232; x=1757399032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Giav7j027e4My3B5JV6e08IP7F2a03l4dML9+8XzWV8=;
        b=lGrZfnDt1m2PthetHfXKM4BUxTBc3xnU67xeAXjry087HL0LBf0HPxKhI1QxVCKnPD
         vH6eH/h/y7btmYpvwKSG3lyE+u/t0acx1tstuYs4OqvOk43qxcfamQg8dvih8mHr/2+7
         urgrROQDufmsjXFFvDNX5Mmpdl+i6DXPl8mHY8oJ8tpTb3uiXvKiLn6StuhKT4Pw4P0I
         AG6cMKPuNaFqpfPhuO3PXB4ldERQS/sEyte/WJooL92sv4hNIgoMh6VJLsYc7XeDdjaV
         N2j8eZ14wrBrZKRXeItIAI301W/kvwqricwvXKy69PxAdkIKk2M3NGvOWMLWDcfM3MJO
         3U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794232; x=1757399032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Giav7j027e4My3B5JV6e08IP7F2a03l4dML9+8XzWV8=;
        b=hl2OLGMqEBUP952WnQ9jDFkmrOlJMXoQA2pJE/BFNtOKRKB4+41gpnjSetvvT5IviD
         xL4O+qBIJVWDUDCNG/2WXYe8eNcZKrigkCFQjaD9aAwj1YqPaPFCmWGfsxKcK09RY3eL
         Nd+zSonF6xLpf3urRqSObDm7LvbOBYfRUzuOFD50+dyRB9ta6nxGZyk49GMz7R9xIr0N
         YxwASX1zLLaiTrfslFBaheHvcFG748c4N6rqVgp8yYZ0ECBMC1InpX1l+jCRNMlV4cYE
         mYo3HD+DwtoFo5ns8QhSwsJ3BGSK7E5bfafWuWGzkJ2mdG/87RsMleeD2p/ScfoJmyXm
         Idzw==
X-Forwarded-Encrypted: i=1; AJvYcCUYmh3z3kuWQ12nxwY8K8PidyTHRSXPUFWVoSwf2KywdiP6gDTC/AZD3cZ3d0xjXxRby9Oun2zCrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5ypSwcH0V1ujjpJULthMs9ogFe3OkOB+I7lrpsV2cqZZtv+y
	IKzcVRFi4JXejeKg9ll2ozlxXFBsR0A+8ERzt4BJHMvj+Xar30ri+ZU1IYw2UeXULrY7efxX0Oj
	cWexe
X-Gm-Gg: ASbGncuYOng+GghPMWVqNUA0G00JQ2tde4Xe9vml+3xgVUCoHxHHPpPj227uAD9my2L
	R4l3WIMahyQCneVhACwpK0TaaINASPCyNeKjCGItyUMjaT9eOAHsOd3wnBTDQRMl+bGWEtf7Fz4
	YVch9QtAlCsoxAVe+FosMK5ShxxfetropXiEAJd1s+Nvx52NMtniz7jf1roQeKymHkJDLa/8THa
	25Qr4+S9OjjeWafX9+mnqxRYsK/Kq0pjt5rdbjRGxafaZdDJX7qylBOaTraCd8NfSCTVpnwthEu
	KE4QVgULFtYEpjPKjC9DKngiSxgIsf0hHuR2Q460rk3vkEy+2iT/G7pflLWMOyBplAyt+0tylbT
	PPLZZDYieU8ZjXNK8tKNPbeLrAcyje032eGQ=
X-Google-Smtp-Source: AGHT+IGRPZAvPZasiyY1AtGkY5yYDRJ7Hy2NGyIACxAlh42J8TV0WWag3m8xK4lM8awcR5hl6BmDUw==
X-Received: by 2002:a17:902:e847:b0:248:9c98:2cf4 with SMTP id d9443c01a7336-24944aeebf8mr150113135ad.46.1756794232129;
        Mon, 01 Sep 2025 23:23:52 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390b6bsm121750735ad.99.2025.09.01.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:23:51 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:53:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cpufreq: sh: drop redundant freq_table argument
Message-ID: <20250902062349.cxg5377chzqtb76r@vireshk-i7>
References: <20250901112551.35534-1-zhangzihuan@kylinos.cn>
 <20250901112551.35534-3-zhangzihuan@kylinos.cn>
 <20250902054009.rhqu4ki3bl4kr5a7@vireshk-i7>
 <34092883-c04d-4dbb-a756-eac89fbe6f3e@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34092883-c04d-4dbb-a756-eac89fbe6f3e@kylinos.cn>

On 02-09-25, 14:06, Zihuan Zhang wrote:
> I also noticed that in some drivers like acpi-cpufreq.c, if freq_table
> allocation fails, the driver won’t be registered at all.
> 
> In such cases,
> 
> should the NULL check be done inside the core helper functions, or should it
> be left to the drivers?

Not all drivers need a freq-table and so it is fine for them to not
have one. This driver looks like can work without a freq table too.

-- 
viresh

