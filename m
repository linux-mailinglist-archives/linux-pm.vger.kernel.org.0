Return-Path: <linux-pm+bounces-23167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD37A495FF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9F818852C3
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A30257ACF;
	Fri, 28 Feb 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsTZ2acI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C0257AEC;
	Fri, 28 Feb 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736452; cv=none; b=ByHrSEOzqk6UQK1E7O82UmYy1tbas3l6nGB5B4UyAI8193ed1QSjh0JvQ9nFCJNTY4C3QG7NR4q75ifSGylHwuxfPxwYyY2kUIpZPG5YURWoe9jH2YAvjKRPY2cwO/hdlgXsRXhcXvv1xDVp2GLr19hM6HNZ1r1GvkIZL0ElKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736452; c=relaxed/simple;
	bh=IEGg4ueY9kQsxlfqP9BGhNHBC+dSukDyS7P2DTQglGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2FMVMk1WuOctIoTSysIJjUmWUwXkCn4xq7lLOWZiMHjp+yQq5ZxHnpFLHebvy8P88ztFS/HTfOja0ZvYYMOLlaRodb3ajy+LHWz28njcEe0gqD/1soqZpl25mT01d/4AHmXoRfELARXy4busQMJciscVqWrKlpBul/M36VF7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsTZ2acI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf06950db5so288841166b.1;
        Fri, 28 Feb 2025 01:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740736448; x=1741341248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFoJmVdTNTMRQouXF13g2o4akpb05wvtrGaYAdP9eJo=;
        b=GsTZ2acI/WObdLu9evQoTyqgfJlxG4qGylh39ynMlZZtm/CBkqIcVRHwm9mOUC3YEk
         WITMwCkKumMwlvhZkMK6bim/HXj1yMGoSQ/3Ul7lzyt1GwKhdQtIf1B4VkmTF2+wsV7j
         mKjlHMd84cTzQAljwwXgu3IGEIaNMdupp8aY5VvRGuWJ9VDER1AjhFPDF8IU6p+BEKiQ
         GsHwTSniN6dXeM0q9970ZQXC0nG2WxcnRyh7i/lhPs7ez6sb30VX5SVuF47A2jx8kAPm
         UKCfkSsufC1Oqvv4NdAlXzZ5a+GnRByZlFSca5Al0z1weFW9c7BDby5ZAi2RS/NqIqPq
         PyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736448; x=1741341248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFoJmVdTNTMRQouXF13g2o4akpb05wvtrGaYAdP9eJo=;
        b=mONnbAz2OO9WxArF+H+rEGTsnnIRyZpEJ0Dj4UxotDEQ06gdqPjFeqFqA6xZUC6YJI
         qOEGjSH83q68qrbE9f5PwbkJn0eUh+oCkkBH8Km1u/3bO5GwSCPYJcR5qMcU2qtLrKEV
         e66PajMaltw1qqR6oG+6w+9VKzyBS6Q65D5nuoZAmz7ptQUYaJtKT+i7lZvW1qlyDLFT
         d58lv0arsM1WhnYRUQpITnLhkaPQ4VMkVvYZDbQHotPsr9PJpmV1bAQGuNthz7CzZQ7b
         Ir/SWM2KHJazp2vwGwMec8MRZ1V0Xu8SGicnBb9DSf1K+A5Cr7iXbSEh2HACJ8sfaFyT
         jR8g==
X-Forwarded-Encrypted: i=1; AJvYcCWOmYYTAVwX0cHJZn/8f/wrEGFaFwKxiv3Sw4kCbIh/Uk+UvQXq2EkDD66y90xeoUUyEmiZsAfSyg==@vger.kernel.org, AJvYcCXvibrurjuqszdXADYlN49WEyWALJgLtZQ+evEYRqTHzevbSvH/tHeVt2MOg1qYEE77e+UN+Xj78iwdkYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqh8Zxtmwxumf8dWi30bw3RiB4qcrfdMq8Dt6MkBOFfcfwJXcm
	m7a8Ni1iYdkTV6ceEGqp+K6jd70YjuJjcwenjN1WFUEEdjoWky51
X-Gm-Gg: ASbGncuvTsy80maaqAPSfC4rz3Rt37VeFzws4IvZNKH6LhK2wUclrbkhf5IdThMP/yL
	H+7suLXvnU1PocmNSm9tZQFMgpywa0r2BiCZ84VN+fM25Uf/rtRjIoTKanGFsmlliGQ5JKwGqPQ
	1SmHZyj87Vy3u845No+oTxZXd95v+uWzo7M9+4tr7vP46wOm2jup07TUV2cVSP51tK6/g3kzVah
	s7GbCAO6Z8hqBESQVclH7H5wAIKSh37apGYzCPvTuTe9dxOTTsQ+iIqV9egwPlW4rXvEinxIS3v
	A/IMg89hQ6YxxvVgjpYMYqjkJ2SjASDcEbCb
X-Google-Smtp-Source: AGHT+IEr0zDPC+/7cw3uemPCbqTlYHqhFEAQYWU5+f2mUo6aVhMRVc8BNb+kO0gQE+VjeZoYjDISEw==
X-Received: by 2002:a17:907:940c:b0:ab7:9a7a:d37a with SMTP id a640c23a62f3a-abf265c7b56mr256398466b.43.1740736447594;
        Fri, 28 Feb 2025 01:54:07 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6e9cefsm266144366b.93.2025.02.28.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:54:07 -0800 (PST)
Date: Fri, 28 Feb 2025 11:54:02 +0200
From: Sicelo <absicsz@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: pali@kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org,
	phone-devel@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	akemnade@kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: do not report bogus zero values
Message-ID: <Z8GHuu8RXkcY8utL@tp440p.steeds.sam>
References: <20250207220605.106768-1-absicsz@gmail.com>
 <CB5B8FE7-D619-4D30-BD2D-58B6CEF83D46@goldelico.com>
 <511351B0-A78B-4517-B183-D39A4F807CB6@goldelico.com>
 <Z8FtlaYkbVG1xrsc@tp440p.steeds.sam>
 <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C0E0C7EA-7C42-4DE3-9FCA-DAAA7B65B583@goldelico.com>

Hi

On Fri, Feb 28, 2025 at 09:27:29AM +0100, H. Nikolaus Schaller wrote:
> > 
> > Will you submit the fix, or I should?
> 
> I think the patch has not yet been merged anywhere (but I am not sure), so
> you better can send a v2 of the series.

It is in linux-next [0]. Not sure if that counts? I guess the only option
now is to submit a follow-up fix?

> And, I think I have found another potential issue.

Thanks for the review. I will do more thorough testing over the weekend
and send the patch.


[0] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/power/supply/bq27xxx_battery.c?h=next-20250228&id=f3974aca381e81c0b1418d8ecc12fa62e1e9d31f

Sincerely
Sicelo A. Mhlongo

