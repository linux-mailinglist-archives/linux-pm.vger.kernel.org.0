Return-Path: <linux-pm+bounces-37085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3DC1F7ED
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 11:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A8E19C04F1
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7A350A25;
	Thu, 30 Oct 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4nziRlZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E726B2C8
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819737; cv=none; b=R8x0zPJdoknHGDk0zDvM7ZtKVx/2BaRl9ObwA/bXWSXd7rPJdMvkaZ0R2Ln6b+bgh7Vq/z/06Gk2/ikjOqlheKkBQYPtS0hVEwnRyffOyBm/yo4SyFfypgWX5YGsT2oxuFVPGhn/e18sfApNbkSJAzL8AJHi3dsDjdu9SpPrq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819737; c=relaxed/simple;
	bh=G1w0BDUSacW0XOVA8splxjQGwNpkVsIpdBFy2H1rlrk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZeKvQoY27l/VbuPi0mZ/5SSLRQc7U2yGUOmW7Jyf39zPQID5CqIID76mIYKgDk6ilPa1JXj05+YOrL/dCDw5O8N58ch6nXqNv284RVz+sabtLUZ3eKdPw7YEwi5UfZQFO6J66K9LRfPSJ8QlnQEqkp/t+9C1zTruEUQLv5Z9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4nziRlZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b85c3880so561563f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761819734; x=1762424534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T2kUtsOiX/qEGmwwQ7Isl75d5/MBlGm1S9q3l+zR8t4=;
        b=O4nziRlZhgxJfb1KvMVN2gNQbV2P+Xo4+fuBmNEr9fW8RTQz+B0i7jpMxzFaal93HW
         k61fraA1ZvcPT12sNxmEgNUZgCz48e3IaclXacyTktXDJ3iypfXBqVTRg3QDalNeTetY
         Syc5iJsTppy0NmrUPDed117+Dc5ebhdsFbJOjx1Dkdye9vKp0adQA7l1vhQZ9UcAzw4a
         HQP6CFKG1F1p8u0IwNRWsny0YSGWj9p5GKjNlKx+V4KbJKplu5d1f0lUcV3GQ1es8sMJ
         Cq60OSKCI0Y74Das+fyAmBL05LtvXZE5ncyaMf2YAdvQhN62ILqJzntogMij8FnV84uO
         ebMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761819734; x=1762424534;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2kUtsOiX/qEGmwwQ7Isl75d5/MBlGm1S9q3l+zR8t4=;
        b=Q1Pw2sr/ah7ajkMnguyWdpIdToUCKCZHnJbncKJiTGWTv6CLpl0Bt/gkPgSZk4YJVo
         r/xZaVn4BoVP5uLeByT/8E22PxmywxGl4r7JqY7XDI789END7oDen3n84G60oOqZmTW6
         Q5yC2LzfmLsL/myRfDoBQr38xFO1xpkLRDdWv5NINkOaEZbWw/3uS3qMTps1Px80QSEk
         mQpcMTZYzxCH+oukTDWZKNTPsi7R7Ieg+v12lOXMVK36pHhNk9uXKtvoS1pF/gBdmHyT
         YYRjpU8zYYI1cRTIy+KWYV2OB6MC73P1O8kFLqSvVBisK66nD+D8Kc2QZvOlukFvIY69
         nPTA==
X-Forwarded-Encrypted: i=1; AJvYcCXsCRWLQWTvJ93lMX+CLEQVS3bWYWH1ZJrsrA9HnQrsJahKxznWKHtD9iOZwm9rIp7CdmVUSfeflQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHF53SS+Sdrd1MaGr9iZO1xGuEgqSdl2NDl46ijkUWC4b2UWLI
	f3GoMzeelvJUm/s+FgcSapOrwd0IJQOC14yCh/MwpFJnaARdvYHseEA2
X-Gm-Gg: ASbGnctZpwfxMjM4Z8mq0QpsFbtyE/dsFF1RY7yeeGCPlmQRm+V2ZQAdRN/FOLIxbA6
	qgCSY8jzKub/1BKCz0yKqSurawQOdPUoRIZDO7I2onSSAj3vACq1BQmGveUVsh2mRGQU36oHXFV
	MCpD3EJZ8JeuUy3tvGpfT7/ljG5txgeGnpYIfnaERGFjastYSLH/T7GJ2vIQ4rGfPqaJDmSQeaQ
	LRWicgAxkCvwHjaJ/cvXGB5S4DJfwnwWYEfAgsOQIuAUtDDSl6UwkmOH0hXXnj0QoQ4l6HXWFjJ
	z11UubSNbc34D7yRtyMb97wwRDmI8eqvD7VLVUcJIvWH0IHmvNMWG43Cx+y9odxQ1PMBH1HFo5N
	OOh4NKdDKknVoTh6QCsY00IT5XM3tEjMScjsk4LqMvHFD7qOi+Qn51Hit3yEzw3kD6f8U58ToFL
	oqr2WoC51aT2bUwzr86Z0eELlFwgwp
X-Google-Smtp-Source: AGHT+IG2GvMxb9LZfEwn29dXFAw3jlFUGhKBMnjmh2/V3MU6jJoVJ3uGtYSEM3H6aIAKv8Kvh0ETuA==
X-Received: by 2002:a05:6000:4012:b0:429:b7cd:47ff with SMTP id ffacd0b85a97d-429b7cd4e85mr1197378f8f.40.1761819733529;
        Thu, 30 Oct 2025 03:22:13 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da12dsm31773234f8f.29.2025.10.30.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:22:13 -0700 (PDT)
Message-ID: <69033c55.df0a0220.1a33d7.49ff@mx.google.com>
X-Google-Original-Message-ID: <aQM8U143LTOytPrj@Ansuel-XPS.>
Date: Thu, 30 Oct 2025 11:22:11 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] err.h: add ERR_PTR_CONST macro
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <aQIzoGnvZWYuHuoQ@smile.fi.intel.com>
 <69023512.5d0a0220.3cccb7.8e65@mx.google.com>
 <aQMheocySykpTFDN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMheocySykpTFDN@smile.fi.intel.com>

On Thu, Oct 30, 2025 at 10:27:38AM +0200, Andy Shevchenko wrote:
> On Wed, Oct 29, 2025 at 04:38:53PM +0100, Christian Marangi wrote:
> > On Wed, Oct 29, 2025 at 05:32:48PM +0200, Andy Shevchenko wrote:
> > > On Wed, Oct 29, 2025 at 02:33:19PM +0100, Christian Marangi wrote:
> > > > Add ERR_PTR_CONST macro to initialize global variables with error
> > > 
> > > ERR_PTR_CONST()
> > > 
> > > > pointers. This might be useful for specific case where there is a global
> > > > variables initialized to an error condition and then later set to the
> > > > real handle once probe finish/completes.
> > > 
> > > Okay, this has two caveats:
> > > 
> > > 1) naming is bad as it suggests something about const qualifier (and not, it's
> > > not about that at all);
> > > 
> > > 2) it doesn't explain what's wrong with ERR_PTR().
> > >
> > 
> > It can't be used for global variables as it does cause compilation
> > error.
> 
> Can you show an example, please?
>

drivers/soc/qcom/smem.c:361:35: error: initializer element is not constant
  361 | static struct qcom_smem *__smem = ERR_PTR(-EPROBE_DEFER);
      |                                   ^~~~~~~
make[9]: *** [scripts/Makefile.build:229: drivers/soc/qcom/smem.o] Error 1

You want me to add this to the commit? Or any hint to better reword this
so it's more understandable?

> > I wanted to use ERR_PTR to set the __smem handle instead of freecode
> > (void *) -EPROBE_DEFER and notice the compiler doesn't like using
> > ERR_PTR().
> > 
> > Then the problem is clear as static declaration require constant value
> > for initialization and ERR_PTR is a inline function.
> > 
> > This is why ERR_PTR_CONST following the pattern that was used for
> > FIELD_PREP -> FIELD_PREP_CONST that was also introduced for similar
> > case.
> > 
> > So yes this is specific for case of static global variables.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

