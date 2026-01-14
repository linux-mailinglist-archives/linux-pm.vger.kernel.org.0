Return-Path: <linux-pm+bounces-40778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCDD1C55A
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 05:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552F8302FBF5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 04:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57992BD013;
	Wed, 14 Jan 2026 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LjK187P4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12A27FB3A
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768364898; cv=none; b=KKDjTdy84c7P4HIq77UpGJKQuG/pnnoMwntz9igpv0E7048jbRXY9+XFXU6le3Xvw4IPXVypp+X4WuRtAh4pI6Dl+mFweg3hzCTB+C316esJjZNjKm342Yz82jUP7OXWPWfRMogiHbI93puHl4padgsQ26IlY8ef7aA7MFKSHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768364898; c=relaxed/simple;
	bh=5yx9xBY+sjUk+qyXfNQz1G/TMrxbfoQFscmKPIPnSWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxfppCGQog4aik00FRIz28fkuqLndAXcpYih+YW5TVLHtRdak5DOjrdI9ctXiNwrRn67MxzuFZW4exTcwSq6NQXNEHEWtFhlweZNl2pjURkelP2J9mQQf8I/MzMTo8S48Gjloyo7S3vUQ7AFUB2rejTL+0iXFx7CSxHNU8yfh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LjK187P4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso3071760a12.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 20:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768364897; x=1768969697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rMb34//xeqnqJBEOQZXK6xmrW7vDT8BlteUvfJmzEk=;
        b=LjK187P4O1cz6PsWKqxHGYOFHg9j9nhb0QBNMX+SexF05xRZ7bqda1+e+Vx/fG1vax
         0UrK0+v21OVf8hLilBeKzan0BD+EsbuFPhJdTtVEqr2n8Du5Vq+We6Fht8BhuijTHff4
         hR1sxKESNOxKbP4g2bSALSGe02JUuWUntylpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768364897; x=1768969697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rMb34//xeqnqJBEOQZXK6xmrW7vDT8BlteUvfJmzEk=;
        b=s1YXnUJh/YP4G1XgcLdzYeYbtQmsNoC7Q0xaD33QMGkVY6Xz1FUzNZsf3UbC+pwdqj
         VCYQj1JsWhhuRn3MYO0p0bfG/ucgOu9NzpVX7T5H7ffJia2Zc4Fu7cRtcA8J8QvyMVJG
         1nKOKJHvChecoQOTGABqSEKed0BNi+XsXOTzn/yjSVGe17KDlmykyIYFjBbXUGvzw0k5
         IPnDw/+x1fuR4W9XMiynDiBshLVbCqG+0QUg+D+Cs9R6tK/TN0X47d5HTmz+Goz9VKPM
         UeWW1uEu6QH7GoHgsOcIFSozL6IK1LGKi+no9wuVrXQPQzSZbvV8uSUblQGLvwF9a87J
         50fg==
X-Forwarded-Encrypted: i=1; AJvYcCW3rYL3Q3RL6dZYkPAc3LwBOPCnrF/p1uTnSkBXEzmaWuCONdXK3smlb7yjNxGdRqQfTfZQ1+Um0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfYtl9IHpuwdPY3TdkLuXwdJBCucjCjfOuF61p2NjQor5O4A3
	oamJrPMD5kluHizi9x45ZfjjPxjcq+vP1+X4KCAiWIR5zL1/hvsqkQo8lNDA+A6WCg==
X-Gm-Gg: AY/fxX77LZhS8QE8uacy29MEUME7Ree9/yKjuWP03dXQEkbzDt0oK2jJIHYHko21DiC
	xIrkhBaGQnGKQMZS7+Nf5enqBmeCqXRZl5nmDJ1diW1Aa3H7Rta3BAMeeiCTL5H+ZN+Zoh3WSfB
	LNXI9hyY5hVnkppxU50hzAZ30Dz9OyvX7l2Ti2Lz+j3umJZ8jYEn/tQKkCXfxuIqN3ONBE95VZO
	VAgnYAw5PG8RNo/O/H74doix65hzQlkp1YpIj++5/FDrbsCFRzLPK5coVhxnV3bCPcuRbLf6WR+
	zQ16TG2uQcX7IKpwCM/NYw/jD3wZGU+SLrBw2OdO/ifu0TKQ2Biv9yxMzhgqYFPJb9FI0sIY/aF
	1H2ca+f+xdNquYot5h7/Z1ewslIZKWHldh9axCFuO9UhHaLQIvK86Tg+IWR44+GHB9uY0V4jcdE
	mQjJmYi2GCbyeV0Nsl79ngkTB0psah4OI0E0kd2X1Ic5WOG7Jw4Bw=
X-Received: by 2002:a05:6a20:9146:b0:353:6c3b:d92a with SMTP id adf61e73a8af0-38bed0b5c3cmr1519521637.15.1768364896469;
        Tue, 13 Jan 2026 20:28:16 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:8065:d8f9:6e13:25a5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d29521sm21302955a12.23.2026.01.13.20.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 20:28:15 -0800 (PST)
Date: Wed, 14 Jan 2026 13:28:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, Christian Loehle <christian.loehle@arm.com>, 
	Doug Smythies <dsmythies@telus.net>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com>
 <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>

Hi,

On (26/01/13 15:18), Rafael J. Wysocki wrote:
[..]
> > > Bumping this as I discovered this issue on 6.12 stable branch also. The
> > > reapplication seems inevitable. I shall get back to you with these
> > > details also.
> >
> > Yes, please, because I have another reason to restore the reverted commit.
> 
> Sergey, did you see a performance regression from 85975daeaa4d
> ("cpuidle: menu: Avoid discarding useful information") on any
> platforms other than the Jasper Lake it was reported for?

Let me try to dig it up.  I think I saw regressions on a number of
devices:

---
cpu family      : 6
model           : 122
model name      : Intel(R) Pentium(R) Silver N5000 CPU @ 1.10GHz
---
cpu family      : 6
model           : 122
model name      : Intel(R) Celeron(R) N4100 CPU @ 1.10GHz
---
cpu family      : 6
model           : 156
model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
---
cpu family      : 6
model           : 156
model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
---
cpu family      : 6
model           : 156
model name      : Intel(R) Pentium(R) Silver N6000 @ 1.10GHz


I guess family 6/model 122 is not Jasper Lake?

I also saw some where the patch in question seemed to improve the
metrics, but regressions are more important, so the revert simply
put all of the boards back to the previous state.

