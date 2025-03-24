Return-Path: <linux-pm+bounces-24483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78028A6E4CE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 21:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31BE16924A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 20:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927F1DDC2E;
	Mon, 24 Mar 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Ko0cKWoR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CF1DC998
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849808; cv=none; b=GsVatPdWyt4cyVuB0GaarnzRG80h+FzSfZxJhf+2+IQouzvdQ08nesjUBhUhXhXdNFXwsCUZjjvGbdKr4ax90HUQ+Fh2wJgOmCnPFtRgDZ/MFcaLE7421YnirglYay3dNbjT+LpQ3riqOtFuJDQ1S2Cfk6NpkxlDgsFLYupIBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849808; c=relaxed/simple;
	bh=P/V3sA25v6913l7QyvxKRXe8wx7j1EMWqQ97PM9AOww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erdGufk3/Yp54Y9AL8IebdYVKovbRXlAlvSfOVJNjo3GxwytHu5o3urfYrZoJxVtrU4iW56RNnry2r/kDtnaIBExrkDn/Z3CTLYJMITwiiVllj41sF/l4xxKVzqki2iN/3KngWTZTy/IgJtQrs6FMEfVWPmBr/6uJnZcZfUa/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Ko0cKWoR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2240b4de12bso21934935ad.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742849806; x=1743454606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyny/RE4kTu/uSuP1NjcFvioBc+2a8T7cZXMNrZrjVo=;
        b=Ko0cKWoRh7lcytcZzHvaU7Zb0jpGuyleD0FWHPGUOq96CLR3Qn6OQelL11pbRYCKzg
         Lh+Vh+0fbPJAWuToZPHJ2nt3iCslZU2WXcBA70qm1clsm/7BnR+kk3SAJpEot3YNaWEd
         R+NldTQkdTbzZCQazO5FdXrAY7WD3Dl+gRCvImHEhJEJKHBSukk/egKLPMF3Y0AFDEx5
         iXik5NDW1/QKOYYgrlH2HPduLSOKNmeJG9lTw7AS4zfwoxn95POFnzWEK9y1/qBeTL2K
         JdsRoTSW41C1ajYVNYmjcUqdrl560Ssgxvb3cj26yJzviKdhtt2eQJZBoch+0fb+iPUk
         zwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849806; x=1743454606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyny/RE4kTu/uSuP1NjcFvioBc+2a8T7cZXMNrZrjVo=;
        b=HijyszDMNzOSpv4RU+qF02bzygHCmB0gBHHcHGecHNEQ3tLTgM+Xt9T2D2nW6jh1Wh
         WvjuKDy0I9cOkg5dIDPFqrmE/JyjkEmylvyS6AVTYJGisRgKdYHCFXETycpLqxkCwi1b
         E2Kt+Hh4d0y1YghNjKJHh3p+gjjInynEU3F8WPpdtbLOiuk51dVQh2MEr7hVJmQoi7Zt
         Elm2BykvHF4LUz2ta5tjGeXdT0VRXVwsxA+4AlBmokgjnFf9l+9GAS0ZZxtNQL/QGk2J
         jo4CDOBA75g5utzS0DsN4GTl/erEtCYT/pVr5pzrntK4NJRcTfNB6Xvn+JU0sCJvajkC
         oIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMHye3nKj+4pMlmff46DqfTdVy702Plz+YmxWbs0RaC0sHlhMZu4LWWQEG/d1PMXdLwjWqid4nlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTtUCyG9NMO/J4ObFKlBr80PxNv9lz88uX/UlU/s9yILQ1jPKY
	SsIXGF2T5RatyKyLmviHUI+CATtqnFhTBgmyq+x5fNv23Jk9T0ZSLF88XmMBSc8=
X-Gm-Gg: ASbGnct1HupkLoBWUdvd7ej/w8q/nUzJgZYc0PHWSXzank5N5DAvmjEIgEern8qd8gx
	9SWRLILW8gR7BbMzmpuHkHJy9qVGH9jokp6CsaDaNIVPiE7KZ2c7diwV9ezpytD5wT66qwOD0dd
	hCGGa3fxZWx7ZtoiyuuxdAcG5W+ymmoQLHkz8aXZp+Jhgmp6V+0nO7ABl4KjX/8sSFUNSeGoKGu
	a7sKnGQr3Z/lRckVWaxcByWKCwN6wPl3kNRRW5ypnIngVxL75wG+nb8Lt66GFHGdMEHVLlB1JsP
	e7EwhYxM7s9dsGVuOcqQmiWZhgWFHaI0wrcrWTuEsh9IlEQNNOuuBJlYcbWa6KdfkkvMsjN9i6V
	3FDB3yn3y76yI82ovgPZj
X-Google-Smtp-Source: AGHT+IHvqTkyWCKz+EHqwOCjEFijgHZgJBBBrv04/RK4mKj9WbInmofIG79TqHnCrUGjEUHUIRqGeQ==
X-Received: by 2002:a17:902:e748:b0:21f:6c81:f63 with SMTP id d9443c01a7336-22780c79ef5mr180461095ad.16.1742849806217;
        Mon, 24 Mar 2025 13:56:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f14easm75526935ad.222.2025.03.24.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:56:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twoqg-0000000HQbc-3e0D;
	Tue, 25 Mar 2025 07:56:42 +1100
Date: Tue, 25 Mar 2025 07:56:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z-HHCrQgWfQw8Y9h@dread.disaster.area>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>

On Mon, Mar 24, 2025 at 10:34:56AM -0400, James Bottomley wrote:
> On Mon, 2025-03-24 at 12:38 +0100, Jan Kara wrote:
> > On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
> > > On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
> > > [...]
> > > > Let me digest all that and see if we have more hope this time
> > > > around.
> > > 
> > > OK, I think I've gone over it all.  The biggest problem with
> > > resurrecting the patch was bugs in ext3, which isn't a problem now.
> > > Most of the suspend system has been rearchitected to separate
> > > suspending user space processes from kernel ones.  The sync it
> > > currently does occurs before even user processes are frozen.  I
> > > think
> > > (as most of the original proposals did) that we just do freeze all
> > > supers (using the reverse list) after user processes are frozen but
> > > just before kernel threads are (this shouldn't perturb the image
> > > allocation in hibernate, which was another source of bugs in xfs).
> > 
> > So as far as my memory serves the fundamental problem with this
> > approach was FUSE - once userspace is frozen, you cannot write to
> > FUSE filesystems so filesystem freezing of FUSE would block if
> > userspace is already suspended. You may even have a setup like:
> > 
> > bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
> > another fs
> > 
> > So you really have to be careful to freeze this stack without causing
> > deadlocks.
> 
> Ah, so that explains why the sys_sync() sits in suspend resume *before*
> freezing userspace ... that always appeared odd to me.
> 
> >  So you need to be freezing userspace after filesystems are
> > frozen but then you have to deal with the fact that parts of your
> > userspace will be blocked in the kernel (trying to do some write)
> > waiting for the filesystem to thaw. But it might be tractable these
> > days since I have a vague recollection that system suspend is now
> > able to gracefully handle even tasks in uninterruptible sleep.
> 
> There is another thing I thought about: we don't actually have to
> freeze across the sleep.

Yes we do.

Filesystems have background workers that do stuff even when the
filesystem has been synced, and this can race with hibernate
shutting stuff down. This is the whole reason we needed to move to
filesystem freezing - to tell the filesystems to *temporarily stop
dirtying* new objects.

> It might be possible simply to invoke
> freeze/thaw where sys_sync() is now done to get a better on stable
> storage image?  That should have fewer deadlock issues.

A freeze/thaw cycle still allows the filesystems to dirty objects in
the background whilst hibernate continues onwards assuming
filesystem are all clean. It took a long time to get all those worms
in the can, and we really don't want to let them back out....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

