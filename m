Return-Path: <linux-pm+bounces-38330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35DC77172
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 04:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62EE04E5C0C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2B2DCF45;
	Fri, 21 Nov 2025 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PCkYEqnz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A227B35F
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694013; cv=none; b=Io6zmeTy8gmia0dQicXjO++1jD3KK1QSZj12EKS8FPvAoHtBFRw9uDZY6n4/QJ/0X5nYFGu/18oNKnVkbu96pq8d3M8GR3Klys78el3/9Tqjd78zJcLdoCTH4oUYbUdrl3P7UeiqeKncbKwmyP2gIrNvwVbNRelVXXnhMqk0Y6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694013; c=relaxed/simple;
	bh=6UnKMS9m0WzkUknJ2P9VGxsS5gNcxDJtdGWfBbGjn1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YME2TPx7/iup0TghgoM1v9STnOzjx/gaDyIQNjbje/66h8uAMPPGgjPfnys7eBTo+NTZpdEAP24fkaTLARL8kz4oR6P9ER3nwvIXBXiDrQ4UpyKRbsOnSTYtDuS6M+AvCoefadnMiiuun3uiappEhEjvYzj8FJf0Qt+coJI0fAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PCkYEqnz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aace33b75bso1419520b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 19:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763694011; x=1764298811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwXQx/qh+8r1jODh/v1DnkHGAbvpfSuxgYbOTg93Q/g=;
        b=PCkYEqnzlfx+xPV/Cqay/WRE2XkIHLn0aPt+yHp9Eet2RPkchzc4kwdn5LveOY2GhC
         AGswL3+58ZmlX8Pb4b7q/qi/L+taj/gtQWnG0Mkc6i3snbnHBbBDCA5sJGhv6x3WZ3Po
         Vy/eiLw3bD+egVfH8fM8Y3mmgsbC2DNjan1Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763694011; x=1764298811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwXQx/qh+8r1jODh/v1DnkHGAbvpfSuxgYbOTg93Q/g=;
        b=go0sMi9KLRY8r1GUoCJG0Syk6EHPXxs8E8NPVA52pDEWu2nsKy4APbimpbny4I+0oD
         4Ow40mbnqmi8B87jFbh8fedfzetVHlptnlF2A6t0eJpTGdQE0y4s6ESCmqlZNHdKfsrH
         pILHdQvY4o46N98DKVEFqgtIDSGAbOCOhZozfsx8k2HrRJfcvsvsKTVByiJMHn9lFNNB
         3bYtUb0hAsGug/pZ94gqhxDMQ9QWgHqRnDBLgb68NIdMy9hCWq3iAzafSm75409wYNMC
         WmXYIIVyZTbWEqsmefYcqKrnkske7NBK0aPH7iC5SUPcJBwByJekvi7qyOqOEHtmNi4+
         DtHw==
X-Forwarded-Encrypted: i=1; AJvYcCWdEW00mEt50SZquLtI3HukeaiZci5TPaAEco6tpubZQPxlTwej2Ac3cY+ufEmAmGd1qX3P8IDC8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jzs1vAjiPqngVMkjC9DoUYq5fGQ2+PxJfHakvA4/2yh3Uh4f
	XX9Bgs1WEhSbfRbXIYpLGgA5C8WURr7d9usnpZAva0iWk6j7cn0aIOyPNWK6AwfqXCaxAKHrkW7
	R2d0=
X-Gm-Gg: ASbGnctIYvZjPezG+Tb1PaF5AuQWMv3Uf+vb4WVaBrT0hQX7n2SQSYDlDMBVOVGnTqj
	3GJcRrUSXMtn3hsStglUYGMIfSt5you1/1rGm4rJfAIUIS50RWkVPqFC9gK+YprAMHQzeMxkeJ6
	KWm3BheRP8xPxGT2iucCghrxCSElyRCxZIcid/GrfnVdJ8KBmz4q68KKmDP+T4Z+dexvlODfM3Q
	6QWbKw5idvqbbNiB93mSTtxnSu/xJVBFrpEbjBtaUx1yjVg+QhzW9sBuT9DZpYJBIJz4HAKkfXh
	F5U5lfVfdlQsgSG0JA5syAatsIJC8RU53Zzv8LwZAS1tJ+jnXbXbBal9qXOP7hzuTdrqWYa3aX5
	5i7FFyRSh5mk6kkemwshQV+wmYTUiu2n8ld41xjHyevQy8IG4Huj4/veG6uVVsWvrH+cl1Lqeoi
	8UGks8h3Lb1ihEEw==
X-Google-Smtp-Source: AGHT+IG951CqwfOawPLG6jVVC1czgIM+nx3fCQxsmCgvHKHhNOQ+U/RwEh2phaqkDepdH4cN/K2ebQ==
X-Received: by 2002:a05:6a00:1895:b0:7b9:a3c8:8c3a with SMTP id d2e1a72fcca58-7c58beb75bfmr652832b3a.7.1763694011521;
        Thu, 20 Nov 2025 19:00:11 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b321:53f:aff8:76e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d849sm4210618b3a.14.2025.11.20.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 19:00:11 -0800 (PST)
Date: Fri, 21 Nov 2025 12:00:06 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yu-Che Cheng <giver@google.com>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
Message-ID: <xhv2eshihzyt3j2tc7oz2gn2gkhucmlnxhoxyrdkxdnxtfwkmb@ebknoqcery5u>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <CAKfTPtAkYfCYc3giCzbDFLBDNTM-nXjkE8FXMZhvJj_im+Qz0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAkYfCYc3giCzbDFLBDNTM-nXjkE8FXMZhvJj_im+Qz0Q@mail.gmail.com>

On (25/11/20 11:55), Vincent Guittot wrote:
> > Hi,
> >
> > We are observing a performance regression on one of our arm64 boards.
> > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> > Rework schedutil governor performance estimation").
> 
> Do you have the fix ?
> https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/

Doesn't seem to be helping.

> And do you have more details to share?

Sure, I'm going to be offline for some days, so I'm trying to
find someone on the team who can take this over while I'm away.
I'll try to help as much as I can before that.

