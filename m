Return-Path: <linux-pm+bounces-3375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13D8495B2
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC831F24954
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67E1119B;
	Mon,  5 Feb 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC6I0Vj1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673F125A3
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123288; cv=none; b=pzfNVWMjlZ1KqPPGzokg+ZWr/DXdQQFmxPWLDTeqImf2lfGrkcRRt0RYfgvNeV3s1AuqeMsrdRDf/JjfXfG3i2a2vysC/ZL/OpGyyE5uCV5udlE3XuTu/Gqmlz5j7JdjwD1Ctd7Ynu7ol8YR3/klkuYqNQisvV8KKTuhIBp6FAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123288; c=relaxed/simple;
	bh=HGW0tJgQKNoHi75+5RzIYowavHplCDKrjC1m5Pju03g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEHOPPq3FTNDuH5qp2Lie3+wa/PtNcBpRR5k2eLexdArv/RqoWb6n1q6L/Pj65ODSYVYYa+Uy/dLxjg9S6T+kUWvpBYDhqVXoDGz9JCwf9Eo2bqojGYoh9eM9PPBmkzYk9AR+wVCkFZtRIU+VUSRaYTbOkirn9khv788DVQD8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cC6I0Vj1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4065694a12.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2024 00:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707123286; x=1707728086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KxN/alX9xe1YAli4rdXZnSsmzCtviymWvvocf9KgwhY=;
        b=cC6I0Vj1h8oKkPc9CoYNNYAuvT8iFnpkYFDToI4KEo5h1wyty8gPLb9Y4Me7VzIqAe
         fR+j58tMikYC6c1I667ZNGeJQ97Ah9Fh7XKNc+oUDETgykEnClsWvE/ZffsMZxB5BpvF
         F0bZanjwC7/emenQssO0oYtpmG86n8RC0pRCr5uz7UxgFuvnUgxO+/5wMzL9oKQfqkoG
         VX6sMeuErF0i2EGqxtMjL1ZnE7aO95pm+hI2dJ7hmCeZxKTVq90Bw2nb60TLOAv7uLDE
         BlVXvRiUMaIfk8tUP3gjw6D5TOa0Vb0Fv/4XFWOBnv2hAArancmBbDyGkXUOz+4g/Pnt
         Gkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123286; x=1707728086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxN/alX9xe1YAli4rdXZnSsmzCtviymWvvocf9KgwhY=;
        b=t5N+8mRWztoFXAoWfOIacIPudpI21lLcPwHzRp5gJ4/ZPRHqGPXQYrDAFsFTFRB13I
         5b2p2pAi4GABhhDywweVCB+h3s/4os2dJ9cGAd7eREZG2PSRF9HiHHsnBPphDZv+m5fU
         9PFkhXe64mtpKEtp/ldGF+Lsh08u8lWfChlGP9QLPQWoAr8ZM0YJ8F9q4mQRY/488e/Y
         YYXvb4HXCTvl2GFS8yNjwqeLVXkpygih2fh7ZrHt2ZOHtzc2IbnSCmuTC/4JuZyR+2RH
         ukInqMfs6cWODwjOZDdl9hN7XcEI6zUJS2drJ0kAgaa/RYViCLGQWgLkq35sYbh3STYj
         iNIQ==
X-Gm-Message-State: AOJu0YwLG+jvlYxuJIYoWkG3dj1pv4KrIvcg4iLRcigbKJo4gJ0P2QqT
	ufstkyJhNaGWWqUVtnn2//HeqHojAQmcNqIFjaL/e8VGTOjhg7aNRJ66Pfn3NnU=
X-Google-Smtp-Source: AGHT+IFqxnLb3cAETmo8qVvHcXijUch3hmAzRC93QrlDymd165i3Fdhstj5Swn6AIlNvua9NDfmRIQ==
X-Received: by 2002:a05:6a20:9c8d:b0:19e:4a68:46d0 with SMTP id mj13-20020a056a209c8d00b0019e4a6846d0mr11275810pzb.60.1707123286356;
        Mon, 05 Feb 2024 00:54:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZZUYF3cKHywyNWGvGX7SyQIdnMNdOQ4vsk42dPgyyLDeJ1kVEpVFHul7N2QV0kaCgljRgXgwp5o3TIk/EaX4lI500LpPS/uaZAzO93YTmfneFWGrogzsHZjzfcZc9S7cjwQh4Cc/KXJ77IYdo4TLju8dHRP07SJfLYB43Xkzq+Xee0uQe6dJoDfoj9yxsilOVlpo4FgKfjcKz3VzHdX6oWwJblUnKHzH/8ogOaAZkNv4=
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id p8-20020a056a0026c800b006e04553a4c5sm1313493pfw.52.2024.02.05.00.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 00:54:45 -0800 (PST)
Date: Mon, 5 Feb 2024 14:24:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: lizhe <sensor1010@163.com>
Cc: vincent.guittot@linaro.org, ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq/schedutil: When updating limitations, frequency
 modulation interval not become invalid.
Message-ID: <20240205085444.2owfuruucm26txt3@vireshk-i7>
References: <20240204140928.2865-1-sensor1010@163.com>
 <20240205073814.s656yzrv56tecji3@vireshk-i7>
 <7654198e.15f6.18d78668d9b.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7654198e.15f6.18d78668d9b.Coremail.sensor1010@163.com>

On 05-02-24, 16:33, lizhe wrote:
> HI： 
>     I think not.
>     It will cause the following changes:
>     limits_changed in sugov_limit() is set to true.
>     This will cause the modulation interval to be invalid.
>     The system modulation will ignore the modulation interval.
>     A modulation request will be initiated immediately.
> 
> 
>    As shown below : 
>    sugov_should_update_freq(...)
>   {
>      if (unlikely(sg_policy->limits_changed)) {
>           ....
>           return true;
>      }
>   }
>   
>   Repeatedly setting the schedutil modulation policy causes the modulation interval to be invalid. 
>   Why is this necessary ? 

This is the penalty being paid to keep the interface simple and consistent.
Playing with sysfs can do such minor things.

-- 
viresh

