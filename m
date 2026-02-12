Return-Path: <linux-pm+bounces-42576-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oECmHhAOjmmS+wAAu9opvQ
	(envelope-from <linux-pm+bounces-42576-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:29:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FEA12FEB3
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6869D301251E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06225334B;
	Thu, 12 Feb 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzujQ1Ry"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E825F995
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917390; cv=pass; b=cJWBR2wKBBo8mnXTvfBH7jET87Tyo0o2ny5c8KSehe2IfjLRJb/+xmwLdasf1sDoxsZWfbEGTwLjCyFO2fonrwHp+0JnWapFtEtXvI/Iv5GA04CLlqnRIVYtT8ATOKw7wixB4d1r8IUFQ3PFywbNtuZ4KXsBEhewBepIG2U0HsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917390; c=relaxed/simple;
	bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o23RVolSeLlShRu7LXl6Va1XKI16ZPYJd3vU8XJJ2zQWcNtJRNsbEYC1DMsHB95mErUKAOzyrFb2/zNh7v7MIm4G4dYO4OGNF+RBF3EnXX8S0bAYoxXQiQBgTZFdRvHUqpjDLU/cwkS3ljFpmrNwmxcE5iveyww82Kb/mrHBxbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzujQ1Ry; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4833115090dso704895e9.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 09:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917387; cv=none;
        d=google.com; s=arc-20240605;
        b=T5QrjQFxFSlr9BMGARbH9gyjFdKSmNbESwr8pSyskcIF4zyy/9eZb2snd0569uKXhq
         iCdj9l1M/zCS6nHjQpledfgWHXoK32Spq4XC6hx3xp9rLi18WkERQqQK8hkgNKNu8ZeH
         7on1fix4cvscffvhjQjzC/x44VpcKkQ990j3K6MY09vgbISL0t8t5AfmaxiGJuLHcmI4
         qUU5cC77O3T9eKV2rTua5KkrIE/Cx6myTtYZ6qM/RzjoDCcQmEjpOadoiKfRoARfNKuT
         PCRhTYzNDYuRrIh1OpA3N3HhQasRVNRwUsRtlPB0y9tCcbp1AOV1H+nhgZgom+kGUn4S
         ajPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
        fh=0AqVkYCg9G/M6mjJ95NZchUB3Ad8w6c2mLjEyEz4aC4=;
        b=lxqw4zuDLXDULEwdS7xQmyri+pMJOamXxTNfrLUpttFjwdeesCWYAMR9YyP0sZIR+U
         wgjg5MF4M4S6y3BlC/DzaDO5zX4m4fBdC86nRU5phSa10YS4ItCTm0OTxl8hXFIZ6ZMF
         IPigpV7deRbKbHgX3EbscaMxmgj2ENnJys7hDrMRTyFt70gWRL+S/V/L67+zFYTf8iee
         tlqbvmbzLKNbLAmkVbPrX6dtVVIeFElaL2QbFdkIdFB1tE8YoWpXH3V0LR2VnvCUiJH6
         6JIS/dowvXp0lO8MQa+ttEsv2iYf4jw1Oik9Cd4N5CLBvSSthg7gzkw1mt3Owm6NnEX+
         htbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917387; x=1771522187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
        b=hzujQ1RydnP441MhMRrN1oTiYkqld0DU28XoyxkeDPloV3vISRyvDdWHCbSO3/1NSg
         koqOyM9YM7eLE+gc5NNw7cWOYqRQ51UJa+7jdrhVqh4bUkTMaSMHCc3WImZoAfXBE62L
         zU5IuqibJWILZg1gk5OeycKNRUrz7a6d5OD2RFycYP7e0ZX1voatYfQzSAkb37x65uHA
         qwR81+/8G71OMRjKbatmVzXY9AH+ISOlW1vdFxTEwC2lr3dhSQPbKw32mjrhrUiX18Ij
         LoFm9ET3L6sqE+B/zvCRGfvbIkkd78Hdky9nz2LXmIXJK1S55x51fmFYBKVgjgw/Vv35
         sCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917387; x=1771522187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
        b=tvi+/8V4zlHwDFlWaXt0tADm5i+N3UQyo/+89qHtXOxc8xbhpNNlBoehVY2X5+D1Dv
         b/jV+gs8WG8+Qpbd4sXwGm8dUS5xdOic3o1xi5ayVHKupDjROv74Cq61N3o5rmfA0aSt
         zlgnNwFwQ4iqzggy8hDqBLre29G9blkJgGaH/IS+FUAMtcWkMmsUABySP7MoZS3xbFQS
         BZLfxC4pjb4mdkeV7bqO0SbGI0yKzoLY9yvzVx1Rlu6t6D9Ll0zEEe2fJMhtEqSoa7mv
         Gh9I/5HoKI/GRfyXA4PDfVKByX7PYfJURD0WoPgym5aQ2hHID93KEoGxTPbDl5Kez4Zw
         D8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWackQPtsmB1mNbC0Jq/AyjSgyoQKWP116Rs9roSxnNsktgTcqlXuM/roLe1TH/dX6L1JR5Ytoe2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2+ZdwPpVu7hONI64+3GcZLK5jrFGCwMYk7VIslE0Tf823f6i
	BGK7r4uabi5YKWdjqvkgnJcYcdkJjHxA+UCGCsBGo0C9u05vWCZ5UX//Z5Uusn0rhEJ1ltnRtfY
	2+p5yCIKSoSZT3LXYWq1SduZxRZ89qow=
X-Gm-Gg: AZuq6aL12yNMfg1wctL/7jSZrrYJUHuIrXH9gsmLUp5w4lLgTBoBzVwnOVHnP3HP4jN
	Dd8WyVmPthLWZJT+9OeMng5SHT6PdarV3gBqH/Z6LjQd3OpVnPNfAmZ1d7TjGpCGiLwN76cjbOv
	hAdYzPa89OpO+VfZMvUTFfip29HQ1+Te49845H3n4/wxxfW+1DNH5keRPNnlLeA9qnC7spk4LsI
	kyTjrNsppb0b1dCwoJLQ872+zg52ReZfB0c5FYpPKWAYUqM1fheSGpQhI2Pg21CLcvVilmqbFXD
	Bzimsf312umOHpOm6RNkj3KV6Of63UFOZ1hc+ro=
X-Received: by 2002:a05:600c:a010:b0:483:709e:f227 with SMTP id
 5b1f17b1804b1-483709ef2c0mr717625e9.31.1770917387264; Thu, 12 Feb 2026
 09:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-1-nphamcs@gmail.com> <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
 <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org>
In-Reply-To: <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Feb 2026 09:29:36 -0800
X-Gm-Features: AZwV_QhhzDWUucMWctDXYEld-DEFpbH6uyQvlM9NhhkkV4HCEsfeHDqKgPzh2sk
Message-ID: <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
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
	zhengqi.arch@bytedance.com
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
	TAGGED_FROM(0.00)[bounces-42576-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,get_maintainers.pl:url]
X-Rspamd-Queue-Id: 21FEA12FEB3
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 4:23=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>>
> Are you CCing all maintainers that get_maintainers.pl suggests you to cc?
>
> --
> Cheers,
>
> David

I hope so... did I miss someone? If so, my apologies - I manually add
them one at a time to be completely honest. The list is huge...

I'll probably use a script to convert that huge output next time into "--cc=
".

(Or are you suggesting I should not send it out to everyone? I can try
to trim the list, but tbh it touches areas that I'm not familiar with,
so I figure I should just cc everyone).

