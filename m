Return-Path: <linux-pm+bounces-42579-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBgeA7MRjmlF/AAAu9opvQ
	(envelope-from <linux-pm+bounces-42579-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:45:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 633DB1300DA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C39304C953
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E82652B6;
	Thu, 12 Feb 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myiEB1Cr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533213A258
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918318; cv=pass; b=OFkDm2XIpqb5i0OBEOxRSvbpAzwfHPeodqZ77RfkVUsVFC2yzJn9aSSMvJiCbQ2UzE7qybaePJnHBQYbAuwfEMb3WKoZaBbM4e3a0Kg58VOr3zmgxYB4c9KapR6SyGOGTytSQOoZlQ/74QqA/8+nAYonKhu0epbYMSaYZ3mwjik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918318; c=relaxed/simple;
	bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYVUN7n+wgnRul3WCK9tREd2kYvGBtmOgGf/OkfNcf99RKjXqVy1E2uiWOBCzDwIyhjiaIYoTjrPxv1xzDZJcjGVU14qqgj0DwdfFV9B9iCE/tfBf48APFga1IvCiysA+3B21nyxkWXXLh4uZgxSXCCWNQPb0ql+UgJrCHzpsds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myiEB1Cr; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48336a6e932so641635e9.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 09:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770918316; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/61/HJiBSF7ESOtDHy6uXUW4Pb4J6ELWidlrZWXtjNvRH6yFzrDk9yagjIOYj1pjk
         knPHdm0sMABiDZ/AcDFLMoT2hVcbv5B0+SE8p07w8BRpxU+N6r10U4HtqQ29pwAvgT9l
         AlDXiF4dQmFTt+gRJrWLkHwoft6hBqZLLIhyVRl0nr68pB3iyrWR83lEIZ99B9wql5l9
         vl6Mg7JDTezAllubD8uJTHBWTPU0+hcV6HRfXFFetk8ISD2c1ht159S4Sxe8D65SuvCP
         lBEaGlsxWqrsn2ncaZHdzmh0oxqyYs9zv9zK3QLSCcLuvGXVRHh7qH+vGDECbMnxHxYt
         GhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
        fh=uoYNcjwNbcD18xZnOl7tPWQoqjs7POV4PvlNsen2J34=;
        b=jZxpSHfptktrfbjR+c56Q4ESGa71x9kaZrqRURIvuSi+4SLEaUYTefy9k4IiwGp+Xs
         3mM0aKJ/JkJSkTztJhapwh5tiO0vp9XjcfMzRZenHSBA6vbuoFLvgkG3BWmf4Q3dziD0
         Z4v4F925Qn8brhEFe+ftwnR7Ag7oj08BSq28mIkEs5PQWCvHd69gce2nU5eH+1e+zF47
         TcxDaeqfR5ZM7iTiq8GTRq/NULJpto75Hog1ttbjMePFNNXC76V6jHgA/rZ2AuOPAzLg
         TJJBlo1cYV2Zuh2xfYRAMSurWuJDO5yVIt8O6e8NgxkNJ10k0H1InZyJVrL9tDP7tUrt
         mGdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770918316; x=1771523116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
        b=myiEB1Cra3pncCKSatOdOo3nCHh2EKHHvaEvjt5M0RO85tbxuO2BB+idSGLfCbZa03
         fi724Q20Z6Gr0wB12cmOIePsSQXSOaIRYituYRKmu47Gg7fG33gLMy738H48YQLkDFu3
         o0t+JymUWto4KlsztaNggeZhcopBj9CUc3GbaC04EPYQpYl6Z1bDuphYCfeUY+nDghZ3
         3agOBerKCpC9TAGWL9AE+b7V8q/SYumWaRvifMWQ03uG1FOyp6ChVYaSVAbB1kjdHnyt
         TQq1OfNabs6Dhk468e/G9WujYLdOjA4e3zvnC4O/aq/8IU6vsruAzB8qbC2bWwV4YxdX
         PSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918316; x=1771523116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w/EHFFOB0IIr1DJv5VOrfT4oZYq8P3Ee1hiCpoYhkvA=;
        b=p1RTFfk51C/LMa3WqnT5RCdT0+3u3UrTpzf7AWdR5Im92vL4mS1hsLN8lSB7MflEQF
         3EOK1k+a1jRafUukMTZ7ClzOBRFO55lVav4+o367vD/Wh7k1yKIB+xFXDLJNrN3oXtSZ
         gGCt2LzSHs8F4E7zrIyukAAcyzqRPzFCunQF+hi5/jy6qZ+LoHa9sgJpekUTBgatg8ge
         70cV5cJyB/cRn9Y9UyXQolveaT6QCHjZdMp+uTe8N7mdJdcInvPGZAvA43NsONf9v/0z
         EqOQCw9e6X8oJd8jbJ0Fm3ZZEs2QNult46kiBFQRKgs6UrKOvvOZ+FQ9u6Fc1KrO5MJE
         bpWA==
X-Forwarded-Encrypted: i=1; AJvYcCXeL1K4fRMLFzhlC5VZ4FaunKpo7T19HHx6ldIiLQgv6WbAMlL41zfJK3kV1Sefo640BVs28M4sMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9K3j4gyiR6GCOmOf6KaMhYwQhF/19lstkVuvTw/r9DqdO3fr2
	EtEqf6ckgzJwg40Q3nuMgx+ZQ/nb7B+jeVn0OOHc20xa5NWxhIAosTzoVASoff+7+J+xwLz4oWS
	2ACSsbupNxPhu/f0C3itLyR76MlGJknM=
X-Gm-Gg: AZuq6aI1103ufGuay1uxbBIjVlIucXKOISAyxh9LhrZVM0jVLV1C5/clD9vH27H/VCI
	j//qtXvO6EssIqLWgz6gH8VuI6Bqa8V23D/wCW7fKKvYqPxgP0bkyWD7w2UI/Q1y4ta2EQuv6l8
	2OK5SA+1DK21KFhAqmTDTfNMlcSr9OqtPCGvLSea53Mv5s9jaq34BBXy5J/a7yrRDDpTxIBL29J
	TXtyVQMsZOJGKF5VgN9N7bvSTPewNzbVBKSZv5BBN1bgou0Q6Dlm0+D+4tGgAjXp5WjVOz63tVL
	TPQfNsYG8TDCZ2DlA2bHfTBnHVKhKmAln0AQZeo=
X-Received: by 2002:a05:600c:5288:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-483656c6081mr56278375e9.12.1770918315882; Thu, 12 Feb 2026
 09:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-1-nphamcs@gmail.com> <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
 <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org> <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
 <3eaa8d64-cc64-4e49-aa80-a3f029d63993@kernel.org>
In-Reply-To: <3eaa8d64-cc64-4e49-aa80-a3f029d63993@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Feb 2026 09:45:04 -0800
X-Gm-Features: AZwV_Qi1_EMWOI-fIh6ISU_nJsN6lXES6EF4dy1h7AM5-pJ3Hm0yGMueZCnJCfU
Message-ID: <CAKEwX=MHx8rabQEBLMrP4-AfyCNYNi5XAi7mWeK1aKgF8y92=Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42579-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 633DB1300DA
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 9:41=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 2/12/26 18:29, Nhat Pham wrote:
> > On Thu, Feb 12, 2026 at 4:23=E2=80=AFAM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>>
> >> Are you CCing all maintainers that get_maintainers.pl suggests you to =
cc?
> >>
> >> --
> >> Cheers,
> >>
> >> David
> >
> > I hope so... did I miss someone? If so, my apologies - I manually add
> > them one at a time to be completely honest. The list is huge...
> >
>
> I stumbled over this patch set while scrolling through the mailing list
> after a while (now that my inbox is "mostly" cleaned up) and wondered
> why no revision ended in my inbox :)
>
> > I'll probably use a script to convert that huge output next time into "=
--cc".
>
> I usually add them as
>
> Cc:
>
> to the cover letter and then use something like "--cc-cover " with git
> send-email.

Oh TIL. Thanks, David!

Yeah this is the biggest patch series I've ever sent out. Most of my
past patches are contained in one or two files, so usually only the
maintainers and contributors are pulled in, and the cc list never
exceeds 15-20 cc's. So I've been getting away with just manually
preparing a send command, do a quick eyeball check, then send things
out.

That system breaks down hard this case (the email debacle aside, which
I still haven't figured out - still looking at gmail as the prime
suspect...).

