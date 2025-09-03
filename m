Return-Path: <linux-pm+bounces-33692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19201B41785
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 09:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA183B491A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F52E040D;
	Wed,  3 Sep 2025 07:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFkwY3uI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF232D595C
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886390; cv=none; b=iD9zDJmkveuo86750zg5cZXuGe4jAAp/BWdSuFtkAzh+UnzAJAeFNlb8mP9sUcvDtURMATTYL9rbp624vkK1XgoLqmaOI3pjU6JUO5Vdnht+sqTO7Wlb7YikXKiEz90qcD9CHTjvHnOlQS95JjNIBzroDHlqaGp7cWsVUaIyskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886390; c=relaxed/simple;
	bh=NuJ5kczUaPyxRvxC+f1VoCqxCsu6DO+7M/ERWYPz9t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT2yrimjVaPKqBtN429EhHygYpmKII/IUNSR/cmkorJxMkrjgD3O3a0KsVD6v1sFIrwM5pxpv9P1035WiOlSKi16R35aOu/epTI6gsYaaW3hySDZhK/ZwzHB5rZnKYMkqvQln1Yii+I43Djlg4bzBpjLBJWerYgElMePj5peBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KFkwY3uI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-329e47dfa3eso1405054a91.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756886388; x=1757491188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxaxPrhxXUKCJIvoF2szrtMVwxxmWJYC9qzjgklL7VI=;
        b=KFkwY3uIBwEznFBSHoIiuTXmc21MjuXj+J2YC6IuK+YWWLbFnZEkoq/wcExbpDfLMU
         p0MpCLm5oaiIssydCRoLB8SnV8Rb8xEnegNEYsIRfSeTKEZDjk/32PcN9FIYeOxrGyVL
         R8NApop+63gUtk5ojnP4NvX6lA3uy8P9M0SVxfXP2JOdruZFvkmpI3c0xTUAQyWnlb73
         FpXWtHMYfdbKTMTWL6KCQMpZ3Gz49/VwOL0MLlQgd06deVyeyrkf6skL4+m+6bTXkyad
         p39L8QM2qkmmja+lhvgW+mVvTKZhmkSowemBHhxCWRy7NBrH4MuKaQLQXh2GCRPQ11zj
         jWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886388; x=1757491188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxaxPrhxXUKCJIvoF2szrtMVwxxmWJYC9qzjgklL7VI=;
        b=eMkYgl/JEIg3sD+skjHTovLNLvtq4xyfzQQqf5/qKDA50dBocxP8JRW8OqRmj2C+tU
         0bXNWfK97BeouwKceUJZ+8ghfDFxpEuJCr1qRmTF0ZKOm87lrX00EdxpLOJ1CZ9cu4pR
         koBSeNRl7jb+Mw3VJRcY2QdK9KXh1WKibclTdSYfSOQbg/ZKRU2j6067Eoc+pF1XglmS
         H9OMr7rIZFutAlPtCD8JF3yhn5Owf76RzjB5H0Z/e0OFdy159gdFEOHtcaMecp5N6OMM
         kPPmDtErjVosEtwV8hqGjwaka0ZoFgwylPQZ0LUP/SlFW1oGCUJztSWXz3YhhnImM/Wi
         DpPg==
X-Forwarded-Encrypted: i=1; AJvYcCW07L4oA/YFDQvutC8Gq8hR/MNDnefclQgN94owMsDesRWFJHQSMUDcs3YhOkgHyHIDUoOw6tTamg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6vh4l+ciuwNvTT6W0IaarmTdTVi5vL+4+9V3iMPWkRn7cwKR
	s95aGGNbRBNac7D67FANCtc372MddzdIXaZJ1B34/NOn6MJ9pEVS4vghAOWtU9D+XMHeMhJr8a2
	exTno
X-Gm-Gg: ASbGncsu26Te1orLQnyvHb7ywVBp6y3yl7Y0HDL67/IqYPw9MiF+W7H8qQEA7X+HZ5f
	P2o/NTUowDxgwBHqu8a5bow5CZvFtVwlaBNyoQbWwDpOSgzdAGVQqGHza7Pw0XPAqAGRCC1kHko
	A6ZDXxEXkRuZqWe69iVtMLtWYdNq2LdPgKhpyrF3dgrJQolMlOslmxUhoRnbOUkHo/PP/IN1CnD
	b2KCD7UJhTQzKkuUS4O9I3rOzj6Xc4aw5TZH7b2YfqLI1Hiuv/143zyE8JEBwwbm+ntVm/zgUiy
	ge1w1xMt+8GDmGutyxWGcS8YYKwNVCLhOdCnvFx71w/705zHpXBEF4cZAUAy6Ie1pqytvDkzGGj
	KQMWCPlLbXSJvdETh4kkkOF6+
X-Google-Smtp-Source: AGHT+IEP2QMbg0XCTQEpNBhuxFDoLswUh1fE6Y3EcWpzAAZ5uDLhKBYJuBQLyDeR7XebXktTSScoSg==
X-Received: by 2002:a17:90b:38c2:b0:327:e67d:6595 with SMTP id 98e67ed59e1d1-328156cc9c0mr18377152a91.25.1756886387791;
        Wed, 03 Sep 2025 00:59:47 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd007026esm13828115a12.9.2025.09.03.00.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:59:47 -0700 (PDT)
Date: Wed, 3 Sep 2025 13:29:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow: Remove redundant 'ret' variable in
 powernow_decode_bios()
Message-ID: <20250903075940.wftjq2uq7tginq2q@vireshk-i7>
References: <20250903072936.4067-1-rongqianfeng@vivo.com>
 <20250903073702.g755d3xtjlkkdbfs@vireshk-i7>
 <4c7249a4-d4fb-402a-b958-e862b6eb04fc@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7249a4-d4fb-402a-b958-e862b6eb04fc@vivo.com>

On 03-09-25, 15:54, Qianfeng Rong wrote:
> I see you have already added the Acked tag to this patch-do I still
> need to send a V4 version with a detailed description of changes in
> each version?

No, its okay now. Don't resend.

-- 
viresh

