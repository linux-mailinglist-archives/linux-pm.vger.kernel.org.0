Return-Path: <linux-pm+bounces-42671-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jQGML7oPkmlzqAEAu9opvQ
	(envelope-from <linux-pm+bounces-42671-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 19:26:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34E13F62B
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AB073000BB0
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAD25A64C;
	Sun, 15 Feb 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfniekBx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2A23EA88
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771179957; cv=none; b=RMMab/rnhNT61KvnyOOHfknvAz61zsGCGhvTH6QCBgE/5AUjdVD72K6ZplMgBmckNslW8ux8swWmC4RcodLZ3fvsuVAuPODRPqbS8jYUt0rGJQuid6c3tocMrIAT1h2DQJolIO3RZI9IoEvzXyUTe2mVVSQDZaVbhvp69wCCVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771179957; c=relaxed/simple;
	bh=3+JNbtyOT5Kt+7XtdRr6TgcdluhUH6LZqtY9e7RLh10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2/hGVZwGvgHwF0akGTwlhRqPEZYd60n/REPqY/LBWltGH/YBsR/bAV8IBWTvHygSQ/jDWcHXOHYpvh+OVBs/gY5eCA2IFPc/3JooS6EoIrF8GGa0tmQd7LDOYW4fZtCbuBP1Une5zpu+5Tktxlp6tv6HeDDGofImSZ7Jg3ZkXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfniekBx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a95bfdb31eso10621915ad.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771179956; x=1771784756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoRxoyUYawYz0SvC4ZTIT9GVYnxJ51Bx8qMLynZ7mkY=;
        b=lfniekBxC8it1UNyXieOwJWvXBC6yjWMl8BQCkL6ZkatAjM5G7w9HOHqGQlK6MCu97
         67DOFO3KHjn3leNIKnM3TlDsCvRweFCYnHy2Rc0kUZeum+NUGcgevYIf8mR3IQlOT8d/
         NmMMMZkbG4y0cZr6KI1ixmSCHQ89SsLN6AXXoAVNPzCivUDB50yTcEldzJ5GkR+jfeaB
         Oo70rq2DGsj9WZGu+WJrnJpmXHzQqUHoZsjv8UbjQwCVOuWYPDtLFem/4hGJ5cDMIHew
         tdDu0C/2svVG7jYrj4lJatKKJzkdp1FdPMNR37ktoOInz93LbjX7SwjwOXXT4TQsqk9I
         jDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771179956; x=1771784756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoRxoyUYawYz0SvC4ZTIT9GVYnxJ51Bx8qMLynZ7mkY=;
        b=gz8Pwftq2HOtRo3Ay7iPxotmjI84EJ5oBURxlw46EnGdciU2Bo63NGq/m55UCWq5/V
         oJvMRmzOxqtb647KoNXiUUuEjnd44WCJy7xbQ4JRgYdjKggCpNx0ZqroquL4fEeakRYs
         bmC0OvlgPSrRRWBSQWsk6OGhRvCaM7Sq6ViFqyj+Its7teewHOoD6RsJ801/i2jup1gC
         46u31BgPINNdVXlnUjPDqgVuHYmIJda5JPSa7nhvaGhEkrbk36L4GJEM5uCXNBcbS46N
         NsnhV1gX1xFr3wNqOLHn5GeIYP+KN1ltI+RN9UQomqVGLLkm6U7mJfD/0KhSfgguj9Pj
         PuEg==
X-Forwarded-Encrypted: i=1; AJvYcCWsngebRy5jvwg/SWICV1QJCv2Io4auhU7oO7P2tDx1Bs0zX8MVgSYj1Rdx70k7di6rgUWfDEJUCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT93JPrsWEGAuu1kQwatDiCZdrmRu9COCcX7Ir68WrZUWkGccT
	3iI/5ePhWZkzMr45H+mJ/T36L6FfPnNXmZeOGHfT4xg795Fz0C0t82ll
X-Gm-Gg: AZuq6aL3FYz+nPviLhEJ+DauZmkPBv0gHOSL11jT2ji6yvSpudqlnHLm4SFg9eAaLFb
	YskZxZ7ErG3KAv2OfpM1m5mn0LRxzsxQwcCWs7HlbOyPiLzsEX9kqIDj1vo+eYybFWdkxw1sEpe
	Yot5SV1qhLubz2O8lNTC/k4V9ekCeS6/h4cEwMPattxp9Zy7SIRs7DPqLa7PHYlRlZ/DMwd7yVW
	PyFexpHlhK05UcQZWlLuM9T7q61+pNlZQgzkVBsqGf3X3kU8zZYCXtKooxF2mku0ObE3l6fD/yB
	cb0LUgtDMXUo3nju2zd8gPAhRH3X29N1k0KXhDGQlfO5+ITgmwifnt0ehMM5R1oEhBxUAvtl/TY
	dkgbFUinLfehIQXxVZhMjFHvyW0fhrN0cw6ZQN2W34RII3n3K/yQ0K1nbUIScApoEEUzXHyRwTA
	Se6UwydNNYzOpeig6KDlngATYQyMzjCBsgjgTMpyvymTZxKgPqJJ4Uspkwmjg=
X-Received: by 2002:a17:903:3bad:b0:2a1:35df:2513 with SMTP id d9443c01a7336-2ab505555efmr82707105ad.17.1771179955980;
        Sun, 15 Feb 2026 10:25:55 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f6bbe9sm17255584a91.12.2026.02.15.10.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 10:25:54 -0800 (PST)
Date: Mon, 16 Feb 2026 02:25:48 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kasong@tencent.com, 
	Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Carsten Grohmann <carstengrohmann@gmx.de>, linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mm, swap: speed up hibernation allocation and
 writeout
Message-ID: <aZIMvN41isdR0JGK@KASONG-MC4>
References: <20260215-hibernate-perf-v2-0-cf28c75b04b7@tencent.com>
 <20260215-hibernate-perf-v2-1-cf28c75b04b7@tencent.com>
 <20260215090236.b546ef526b9bb6315f7884b8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215090236.b546ef526b9bb6315f7884b8@linux-foundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42671-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[tencent.com,kernel.org,kvack.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm,kasong.tencent.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE34E13F62B
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 09:02:36AM +0800, Andrew Morton wrote:
> On Sun, 15 Feb 2026 19:15:05 +0800 Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> wrote:
> 
> > Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> > hibernation has been using the swap slot slow allocation path for
> > simplification, which turns out might cause regression for some
> > devices because the allocator now rotates clusters too often, leading to
> > slower allocation and more random distribution of data.
> > 
> > Fast allocation is not complex, so implement hibernation support as
> > well.
> > 
> > And reduce the indent of the code too, while at it. It doesn't have to
> > check the device flag, as the allocator will also check the device flag
> > and refuse to allocate if the device is not writable.
> > 
> > Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
> > performance is several times better [1]:
> > 6.19:               324 seconds
> > After this series:  35 seconds
> 
> 10x is a lot, so I think we should offer this to -stable kernels.
> 
> If you agree, could you please prepare a more backportable fix? 
> Something minimal, separated from the [2/2] cleanup and without the
> incidental whitespace alteration?

Hi Andrew,

I think this is already very close to minimal. But I can send a v3 to
split the indention change in a standalone patch, just to reduce the
LOC changed for stable backport.

I'll also cc stable too. I think we only need to fix for 6.18 and
6.19 right? They will still need manual conflict resolving even
without the indention change. But I can help with that.

