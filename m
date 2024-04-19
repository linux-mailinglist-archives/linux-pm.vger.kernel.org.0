Return-Path: <linux-pm+bounces-6699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944D8AA883
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACF21C21001
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608F39AC7;
	Fri, 19 Apr 2024 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flcJxh5p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79937165
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508801; cv=none; b=DDw0e9DjnucrLvHlhmvO/F49zNM/ZGj5oEprIG4+0lJpJxmJDuZ68oRGOit+rql2eHjfAdqC7+NdqUWNgQJr377Cb34jIcE5KGykh0RDrQ4eQOVk8HkTJT6AbXdaVT5LfTNRLdUeKv6Yc4diKdtRJi7N3tXcjvbatdnyQ5+S+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508801; c=relaxed/simple;
	bh=KO0xtQBpQZiR18joiWf/pJcceYmytvVfGuc9Q/51F+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWvoawxfiwv3MJ8fDba/OxQUAbvRuMLQzyq7o0qyIsDuekTiFTLJPWWxMm0DEmPYgB38WXMwCIJh7NnzBR1x9LF1QC6hE0SJ1936JOvwJoOXuLANaTjbZUBMMdhEo9A974Bx2l31B/TvPlS5ha77BTPEaACIrrYay0SeVHmkOPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flcJxh5p; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e86d56b3bcso551745ad.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713508798; x=1714113598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=behcu3HpDw80Nj2+p0givcvikiqXXCDSWOXRNk2VtxQ=;
        b=flcJxh5pTRqmt1tEeDf4ShvoK8kfFrlWV03sHvgHpD3e1G+1oVT9c2Iu+q/aJjpYox
         dnpye0oFudh3dyqJa8twv9kBZEh39Ks3V9LMLwS3T0EOdrrnnUEncJnH8makE+s6oVb5
         Ss3vI2Zg8bt1OYyVK33LdgQv0X/OP5V/k9DzE+Q96hPEBIBdNUBDLmXtX2m6RoG0dc/H
         HzSWEI3QhVH1I8KGc5zudJQ0nphwdEUPd5A05TmYmfux+63Qla8j2WTQKWVUu6mVqf0G
         WYBP6UcYgU5zji1hbKClu6JEKdCJ7Tlqa02PsYLQLWYHEaVfAKoluuoVNzEPQAJiytau
         7PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508798; x=1714113598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=behcu3HpDw80Nj2+p0givcvikiqXXCDSWOXRNk2VtxQ=;
        b=nmdpFZ1OBVchbonJXd7QYdVhGD6d/Kj4l4Rwrli+JFqksKTW7eahWjqn6odzkqDPeW
         2iP8PAl4M/ZTADYvN1I5lED6yzawMLUUsE2O/6hhBTRXZlGmyYwhxoJRC9Vj9ufUW4vd
         nH5T3SuisG4TvtAmFuXSww5ycpj+hgB5FwrGVmtHvZeqJ/ysSs5GDHGev4BBKekJpXzL
         +jojNQ5sLRlkEUV62eM0kU4c7I9aPAdo/aTbj1x11KLZx1+92xE9L2MnQ97RUNv9D4Qc
         uxC0rdZHNsAqVLv8dOiJyrYQIo1byphzHLJzQjGnIcGqJPOrgF6UDlfhijbOmRNC49xH
         i3xg==
X-Forwarded-Encrypted: i=1; AJvYcCXpflg/TaSGKj9qaKBDtLUrk4N4fsqo6J4Y7DTnuEXk7ylX+jW3awev4Z+RbIJ0eKIHC71eOvNZO8g+H6QP5BgGckN9aHrsc/E=
X-Gm-Message-State: AOJu0YwxSeE9D6mDxhjLuvyy07EIQ+oTJHhJCeFrQsit5v7hyCimUwhI
	l0NZKreGcxVL1yRZ7qpIqd1qyYKON1Csh9Mwp0FxEp4PeJiyiw3/twyU9nxb0Qs=
X-Google-Smtp-Source: AGHT+IFjC4SYo1RfgyjASxoVyHVH5G3r/xD7roVjnqsMZux+u6GUIuiQPmKURIcdYeJqQKak87M6Gw==
X-Received: by 2002:a17:902:ceca:b0:1e2:a449:da15 with SMTP id d10-20020a170902ceca00b001e2a449da15mr1420976plg.15.1713508798014;
        Thu, 18 Apr 2024 23:39:58 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001dddcfca329sm2588042plh.148.2024.04.18.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:39:57 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:09:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] cppc_cpufreq: Fix possible null pointer dereference
Message-ID: <20240419063955.jzfd6pfiag7kz2i6@vireshk-i7>
References: <20240405094005.18545-1-amishin@t-argos.ru>
 <20240408093536.19485-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408093536.19485-1-amishin@t-argos.ru>

On 08-04-24, 12:35, Aleksandr Mishin wrote:
> cppc_cpufreq_get_rate() and hisi_cppc_cpufreq_get_rate() can be called from
> different places with various parameters. So cpufreq_cpu_get() can return
> null as 'policy' in some circumstances.
> Fix this bug by adding null return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2: Fix mixed declarations
> 
>  drivers/cpufreq/cppc_cpufreq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

