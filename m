Return-Path: <linux-pm+bounces-42472-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKYOAMGFi2neVAAAu9opvQ
	(envelope-from <linux-pm+bounces-42472-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 20:23:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4411E9E0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 20:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03918301E963
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8D38A728;
	Tue, 10 Feb 2026 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6lA8u5V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF92638B2
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770751422; cv=pass; b=nwiK6wCHPaoQx484WCi5QHVYIpnyQD1+GMWswHo35wh1OP3YaC9orw/nXgCz1aCNMk7GsU1Y6vOPVpraoOwJGPzX6Y12MGZVaZ68ylSaHyBAAENCLq9EBesBhY7U3H2l8xFHAdYXaN8bGGQGNyV/W6K56uVV4fy/JQBdD8Av/go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770751422; c=relaxed/simple;
	bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=insVxQLhIluJjhOfqNZ5h/2nWleLUFLypMMJJH6Q8GCV9H0RG+9mWssOroRWdWfPdNSA4h1n6/LFrpYW7BsnGwApjepZwIu63zQDxqPpJLj3L/E09qVThESFaMIFfx9SF8TfLT1tUc8rkwkzgRfui0W/cUMjUigsRE7ANZ2ross=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6lA8u5V; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso1565815e9.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 11:23:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770751419; cv=none;
        d=google.com; s=arc-20240605;
        b=H+QUSmN+wSnh+JTa+ZCKASjoQhH6PmiRUpAHCWJZ1YHmJqNToHUAYjs/IxvL37X2wK
         2qF+5gtpY3TUqCukkOi9EQ7nUB4gJAYIBwVZCskLDlR8d3vcASs+UFOYM83ApDxwlHRq
         iyiyirFm1+CijaROVMAiITNCZ7mCR+DGvkiZa5aozAYB1qBcGjXchoa+RLha+8eElqpQ
         Q4YdYCW60DQO16pBMDeiXnmh+55fUiZMZdEt+E6IA68AXQj7wjbPycnjCHKxYOIY9cO+
         10uuVQaAJ46RChdM2nph6Oh1b4Uq8pqhHyeKi0fZOkOZh1uiIdDe6Z6Snrf6ur/+qW2t
         NH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
        fh=nvcDrKbqbgtv/WRRK7Oq7pb8ts4jrXS7D5myPvL0eZM=;
        b=JLpj3wKuFbLz9pbQu3l7aMRPeaxjvzoX2Ki6qANuTkf3DmHKIiO4qcLDEvKMD/YFYZ
         mhbYxlrRHlIiQT/2UVwfU4JBcLkPSJnOemPl/ak+6hC2/PyR9ivBNqboOFmu/Il3U0hX
         +L3Tb5OtCtDIpkT7o83G6rLUpQbET65mKoh/IiFTYl482gZWucejoxdvHWhPPcQy6Iqt
         jNxFfXxIW0nW6nb1soafQmgqo3yr+5cBDYTjeREo9MPwLRzerSCBzUlpAyXL6cg+uUtk
         BzRcz3WikMmOmAzN+oQLvCOXlpG6PNAGPcdvbK4Q7rXYhqj0MuihfwNCRVpvErxuRmS9
         0E/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770751419; x=1771356219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
        b=S6lA8u5V+xZ2ut4fSKTSKkBPBf07tiJv+F20Kb3OWHYofk92XZcJ4aJP6mda1lzfL4
         nVt/O1lL4la3TC9a6N6QM3BcOcvBY6fRvsDl7IUwo6okJvL9gx0S3QVfxzTuKJ3OWTGV
         JoWj553UZsJ62PxWrejzR2cXZfiv1tjYPhDdiyTrKPaBZDn5h5UHoGeNFy+3wvZ+BAFf
         2EtNHEyK1YiFbF74zpI97mFdtyPdrjVGqV6l5SGQBce+J7sz873twsyOekm4ssIynAxN
         YN2Rmxnk4DzR0AgQNFv9WRaFFMHI6mJnez4EP2mAXDC10l6XiJFGjn0mr/hKua1o67bo
         PVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770751419; x=1771356219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBYVGOJgAAh0wUGtGHCzoyofcM36bp9tfn4+54TVIks=;
        b=XjhvmpPwmbmaLwTPwnyWHFavdEDBnCFYxmhFqniH6MCoz2D5gmAvwslaa9an9pUW0D
         qEYwbKoM/DVMmOskmmf4BgVmmDOcAe32iGTplUx5250cd9ZgS69UJ4jBwzcp6zb7DxfB
         Fzzg+eTWEEBMD8hHrLVm2c1pkwHAZLWmvkXwHgfpKNA0aaR2H2HydmCKeKbuJByspgIs
         xFHjQs24HXRk5JkRLcCBYBg35fOAB4Hvwh+w6I9KLRMd5xCtPfVS9rcJ0uPOhXjvNI9e
         +ueXQp0+rUc+41csUCkybsShKm5jRWBMATh+kLbMlnw4eZaTvFpP9AqDdLNQh0D4/Grh
         75iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSYjPB+dVav9bHEiLNq7XzWEvyF4296ZSWlgTeLBZiURdLDa1MMHav5PALh44qTFYj9Fwe1MyRXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBINXc+8AH3rTZhF+Su1lx40R8r1U4QZ5Ee3W8Plz99CATcPB9
	s3UMnsk2MuPc6GCLAtbqHgaOL/i0iTkjUsTegO+RymE7wd6oz+QVCKfIlBWKHxUrLdL3YqqLvCQ
	VHHeMgSBHx+kWm45Xq8f6FZKuJpkuMYA=
X-Gm-Gg: AZuq6aJGAj9jsqr06L38X5CGEaHhBOFJsOYz933vX6y5I4BhI/CNO+OU3PdDi+Ifmj8
	nQ8kWU2ZvPvUa2i1v6c2HytqY7p/RWzjmKiFPJWCjk2y5UqnDbUnfS7MuPvgLwoAad5wBzj4vOH
	QtdgMey3/1OxxjUjiXDU0ShaBLdPXtzcfn89qWNFLKTaMq2yz/kXJWKWuGweOhDukLY4N7iC5hx
	F94Rm785oeqX82eYvChVUO/4QOOY6WbnbzuycI0dpbkMcH8uvFt0FrHSb9hy+h1WwHU5Khce7Pl
	0A8yEte9L7HYmCPqaWtgcDK2lcXJgoQEYZKb2ZI=
X-Received: by 2002:a05:600c:5288:b0:483:14ec:5925 with SMTP id
 5b1f17b1804b1-4835022927amr50988035e9.2.1770751419161; Tue, 10 Feb 2026
 11:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com> <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
In-Reply-To: <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Feb 2026 11:23:27 -0800
X-Gm-Features: AZwV_QhDHop3xuaKmlrjyEY_sdgVS3677YBZxGUueqqiU-9ugNQbef3e4wRWWfo
Message-ID: <CAKEwX=OYauRgQoj7cxznpROknHt9NsKLOmkvaFtkEh8T1KASag@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42472-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4FB4411E9E0
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:11=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>>
> Hmm this one I don't think I can reproduce without your laptop ;)
>
> Jokes aside, I did try to run the kernel build with disk swapping, and
> the performance is on par with baseline. Swap performance with NVME
> swap tends to be dominated by IO work in my experiments. Do you think
> I missed something here? Maybe it's the concurrency difference (since
> I always run with -j$(nproc), i.e the number of workers =3D=3D the number
> of processors).

Ah I just noticed that your numbers include only systime. Ignore my IO
comments then.

(I still think in real production system, with disk swapping enabled,
then IO wait time is going to be really important. If you're going to
use disk swap, then this affects real time just as much if not more
than kernel CPU overhead).

