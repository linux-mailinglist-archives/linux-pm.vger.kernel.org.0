Return-Path: <linux-pm+bounces-42577-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANVIN0YQjmkM/AAAu9opvQ
	(envelope-from <linux-pm+bounces-42577-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:39:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 808FD130003
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E37A93012502
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6CD25B1DA;
	Thu, 12 Feb 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/QQM+VG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3272923ED75
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917956; cv=pass; b=qvfuHlr+8LnJHWAvoIdPRsmoNSmEyt27I/ZFfbStjJ8Y3NQRjOzo9waEP3txBdTTYimCO+ng4+3mHiGHYEnwvqyJPvdhDfLoDnPKitcwCgDZYaONW91C+cUZZ+FbUxzFzcJEW34domdz4qJZKDMhlzfnjYwjkbffpxRdfRKr964=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917956; c=relaxed/simple;
	bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQu0Ig6yPmyKNpTIrHwwRS9oK/8sJkC1HBxFP1j+uszwN33vsMhMVUtx7oNdLnBo8OAGiA9G/LwFg6Zt5/4ZVj8peSQHJXEy+McyetQyJr1Bu97PJsMJ7udeuPxE/Val9rb5z70OoQZYdGyBnYpVzv+OVxWGzdgTCxyXwHBS+h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/QQM+VG; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4834826e555so904105e9.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 09:39:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917953; cv=none;
        d=google.com; s=arc-20240605;
        b=GDUGpdfan/9uovMIClHpr2IlGgF1Fr74GahKOWe/IfB+yqSWfP1rpI79ZXbzFk6Hb/
         bLHF6czfkcEti8m/azEMJpfyVZO0fU05NYDgSk5Mvb6G5jJpBffd8rRT6ulW9Af+PM4H
         6vfF58byG6B0YzVIPYwgEkfmTI6/P9pLTJO7N8ANnypaj4nxmEI2qtorMk1Yh5nGwFdt
         WMm9vFMnDQ69edQfu5uuJv6+h7hgxHRCPVXSnlWIRYDaH+cyVMmhoQhA4Z48tIT53A9F
         qoqfGmoRyBOx80nJcXZANwLIkgRQXnlCpdpIbNwCHqX61FdimvGLdpdbUIzZ5oY4g4eG
         tZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
        fh=u5sa/Yyorkv61IfBEKd2TJYcxc4Y7dgEDi9Bji/uhqE=;
        b=IEVPQ4+4ds9KeKKuumf2D09UR4J1absT8s9qUrPEhNJ1kylz+/rH3fA5qw1DVya6hF
         M9AbvIluZLyRAVJG6uNp/V3qKIHMwAudjbQZf0jUiCJauuilBnj6YqFLDwzFbTtNEEYr
         C7oWTnNoK9AI+O+Ew8ctDhO2D6aKJUz5B9QJw7r1xkzjLE7/cuiBrrgmMtFKCc+fMX6M
         WkEC+rxM4ZXZM0QhY5pLp8QuN+qO8qYTBt5sR0eMiIIMDg+vpRHS0bCZRS+gzBbtNNoJ
         AlCvUfN/8XM8K6BM5xYZjWF4+1dzbRZucprVo2Z4W36OrnLvUOv1XeyXwCrbccBNqCPZ
         Pa8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917953; x=1771522753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
        b=K/QQM+VGrUoxJiBLZrTobZf6pSS0BbZKmzWgDuDBRYEMMOu6xRoDybsEnVqltlzywq
         3s1CzxHfDRZ7kWF9+n7d2SFFMUw+dCn9WqdUK+5S1sDAbIgAx4YiTrr+Pk1rte/xD4hZ
         mfmKxPsX4EJlX+0jgkuDgN2qZWq5BFRCO+zSWhK1lkUbk+7gG6gXAxdotlpF7xUAEXsp
         0eAVA7ilfeY9zXR3Y71BDU8AWmudlq24yP+pcoVL6n5LJT8d6kH8tneuZtLsMWbkzKWq
         westECOujWxXnzUPr8wXSVNiG6z/X5x6EWJwXM1p5zaQ9QOuYCHLnhySdH69opb8WsW2
         uS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917953; x=1771522753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmDSu9rHdkQKCyukTIemQGDTasI1Oy6wKb2WDyCVFJM=;
        b=weS7v+XdLSvmWgwBUnbXsCKN0FEOGRtqFPcJWYr8NyNmzlkB6TyWL3milF2aoT+kJY
         9u51ArOKvMhsR4Uu1y8n92hlNkPOByg3vurgTjpesHldaHDi2diKNTD5BLu6AAl2JLp3
         2itIpmt5pF2zGPbaBA9Y4AxD53LWrKsnqh0Y7JvU225zMlRxty0Z9nQCC1/IEtztk7fC
         mQ+MYBnltrNu4FXMJEj40EAT07rpJPy2ULWFbj0PD5EiUt0U2wy8hO+9zWX+e7d0fiAS
         z/394dPrZEYrNFnwWRH47BhvJO/B3AYyOmAiysNKOy5A0jwTbQp9K/AwSvFRx+XNtamE
         nOSA==
X-Forwarded-Encrypted: i=1; AJvYcCWevGbgV8hsfyOt+dl3GykDNBSrzP/YUDKlQL5Lv8gfdLf8mVSxdj1ZBBt5EP0adJz9x+YlfUulyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwveF53TOX9AXzQtrZuzdSZ1YbJV+LQfY8Uom+X2CB1XNevi/ow
	uM5PukjqqIMI7XTHvXFzPRjr4a8Sm064B8/P9jf72QvJp3F5sLrQ4qLlMpDZj/q/HevHUWdo4oD
	0gtTeGxAeeErs6yDMi6TFS6BHIksyK4k=
X-Gm-Gg: AZuq6aLhiW2Xs1zbhxaaRxJ2TYm2gaufQQIu79TpaXI0qFK2xmXXPKv6cpndDlLGkLS
	ecpcaoBmT7aa0sfPEqaQ8FBOxPM+UfFg/6tn+7CvYq3lDVWQPDuAfstuQ2cUdNTm9dll4v+0dcd
	w6yPDuVUkWScDaRixkEh230tE6mZwpDXSPIoq1qy9oq9fPfmPCL8UqUop+siEdu8waElkpzEPk8
	fhgHpeHyXzBJAemE51EiCmpng1nuzxW7OQ1V5WRdvPRpX8fvEUrlFf1akkImE8tDy8YEh9I8ah/
	k8m7kOs1ahwbP9900I2UeIaeuvfNg5mpHjcSWkY=
X-Received: by 2002:a05:6000:4024:b0:436:1b1:6cbb with SMTP id
 ffacd0b85a97d-4378aa01106mr5591885f8f.7.1770917953341; Thu, 12 Feb 2026
 09:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-1-nphamcs@gmail.com> <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
 <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org> <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
In-Reply-To: <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Feb 2026 09:39:02 -0800
X-Gm-Features: AZwV_QinV0WPB7Xpdl--Xq3J6j8mlfT34orj9Pvsm2hWI8SWmVi_aDb838NayvE
Message-ID: <CAKEwX=Oqn5vZrYnURqwoNBhBmA5xU9jy5-5ti8vzFs2DHDaWYg@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	bhe@redhat.com, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, tglx@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, lenb@kernel.org, 
	Zi Yan <ziy@nvidia.com>, dev.jain@arm.com, lance.yang@linux.dev, 
	matthew.brost@intel.com, rakie.kim@sk.com, byungchul@sk.com, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, apopple@nvidia.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[mail.gmail.com:server fail,sto.lore.kernel.org:server fail,get_maintainers.pl:server fail];
	TAGGED_FROM(0.00)[bounces-42577-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com,suse.cz,suse.com,lwn.net,infradead.org,linux.alibaba.com,nvidia.com,sk.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[59];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 808FD130003
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Feb 12, 2026 at 4:23=E2=80=AFAM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >>
> > Are you CCing all maintainers that get_maintainers.pl suggests you to c=
c?
> >
> > --
> > Cheers,
> >
> > David
>
> I hope so... did I miss someone? If so, my apologies - I manually add
> them one at a time to be completely honest. The list is huge...
>
> I'll probably use a script to convert that huge output next time into "--=
cc".
>

Ok let's try... this :) Probably should have done it from the start,
but better late than never...

Not sure who was missing from the first run - my apologies if I did
that.... I'll be more careful with huge cc list next time and just
scriptify it.

