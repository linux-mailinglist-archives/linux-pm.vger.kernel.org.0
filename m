Return-Path: <linux-pm+bounces-42793-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCdQOKv7lGm8JgIAu9opvQ
	(envelope-from <linux-pm+bounces-42793-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 00:37:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C820151F40
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 00:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9844301E9A5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384582FD69A;
	Tue, 17 Feb 2026 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVphXrGh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15630748B
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371409; cv=pass; b=s654P7ezw80D+P3oOcSh1+VPnkzoxvbcTYI4/ZI4mApAXHGPidogMaw6AnziRdcpyMlM/FrJOKmenOBbjDJIiS/d2/Wuep+m+Dk9i9V9wIYtFwqlXbfNM81/XWzmTgCisrB6FvmxUzQMnspShWGzxUl8crZzg3kD2wWNMDK4rxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371409; c=relaxed/simple;
	bh=MM5voXXZM97a0VTnbbiWQBfsAu8METGN0ejqfgD0KW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG4i1p0R6XXG0dwC6DcMMxcMlgtlY7cUPrnP7Or/HTO9vHAlfKqZ49AbHHdg5Oe+iMoDSgAJ+6BpHQ2DwGiXX5hI9z1kKKcjLllfmrmXjMJXZODI3VgrF0jRU1Q4gedkPMhpBLoPBeAwztRHBmnoMssEE2lqQXJtAQp+ViQFoFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVphXrGh; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48068127f00so50392335e9.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 15:36:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771371395; cv=none;
        d=google.com; s=arc-20240605;
        b=bzXFE9ovgSLL30+S7qUxwg/8lexjLNhbjF5Kpt27D36tjaLRwnLPLRjG3ABysE6Lu0
         dwClrofoFzFcMYVUi4JfBMepMcJZaDzb/nJbVLXRW6i2ZNCMUmE2dpmO3zImNZAGOC/D
         LSwTY3DJKKqalUIgj8oQL0o1oe9tfp0ekW/A101QDqj/P8TMOfQbmwsIkD+V4jtXJRya
         GD+wSEsZnKW1ZADrZtj0dg/4WmdbVfHhBhAvCZ7vz+oWD9p3GSEXDZWOV+qN8JslHPPX
         2eqOKeaJmCogaPXQI482cCfZvdUT+dKTHTrQ0o4UvubVTgW/xJghLuhD6ZIEKMIwUhOm
         tnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wk1effero1CXwxRd3Bkv9v1OFKIW6OFHxrrQapskabc=;
        fh=8d0DOHp28g7ycam5xh4q0BS7aEELPjjN9AUZn4I/o2o=;
        b=jw0hqQrxtAvuXGIqzbANGbXNMJ/cYzukqlrgjNaIWwxxc+8Itc6/LsMwJq6PVQjFJA
         Yaf7bgiJFlN/EeNh2ZdsHlHMsE9qyKF/P+k4N9tRdaPpYbnlmjNPOf9QSJbM3E4+lpWm
         xS/YTfwTU5Y3D12VEkSMBsnnTO2AqSQKXHjWq6eZu4znH49L/e+6LRezf3yzCzbqHIdP
         Db2/fHqPeh3yclULbm77cxGp+Eq7WP/7S4NPaLavPqUgMdoMv/md6zkTuzAkkDHJDnMU
         7BJGqhAthmopICBq+Ji5g4qSms8VDkPZRAmo7Qbtgdp1cL4PNI9QxNxlih518pPNjbnV
         uIxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771371395; x=1771976195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wk1effero1CXwxRd3Bkv9v1OFKIW6OFHxrrQapskabc=;
        b=RVphXrGh1sCb3PEzP3fU2QxZv8MTl8PMPkxAtgoWYQdLSPeO5aZCisKw2unaKVf0yX
         iRbtwmGfIRKvjnLcRqWxslWDB9o4w3cAsfbgHny/qMSyCj2msSOwf0Gqjd4V8AQ+AoEL
         Sxmziyh5G+tcNeUkTJWR5aWcHLeegWaE8z5JHiXuCoVwrhqBaztnbvcaiKX610EkOazM
         nDv03upb9ZYJjttixWg55y117UBN2Z6Mh0H5vCP4K7y+90EP+3EVkkN7qTplyb1zE69F
         eMLCUagGqlP8UKotJmxlTGoS28kxXsxZl4iMl1uFyN8BXOT8NZGGyPz2PIv+DqZwo7Cf
         F/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371395; x=1771976195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wk1effero1CXwxRd3Bkv9v1OFKIW6OFHxrrQapskabc=;
        b=IhmChhMSf5ghnBL34Gc6WoegAObuFIjY5RDx4etmXWDO2GR5/ECceZD82+k8npWy+r
         Lx6YekyStxdVuDtsTOMAYcJeVOh8LoXTUqJrDCAlZtmVETyuoHEpoSTT9gwfvCq5pAWI
         1xRkLi3gahRrZiQF4q1eYLH0ypMgvQ0oVWuC8SF4zJEp1f9ygFtWFndqaf0HmZWWrcs6
         tkJiUM4XS4VOHNoXUjkW6kBwrYzxfBCenSSs6I4Ho4vl5NBtovLTVsRbBiXMK5YrDX+Z
         hqOnoVqlWXw9DBNfwJsqsXChwWDdW4OGFsr/o7s/JsDXwMF1ysHg8AAHVNJjsb5gKG2E
         VRbg==
X-Forwarded-Encrypted: i=1; AJvYcCX2PQJtWWdvjrGUiST5pSl1Mqm4oCPjUEb8VJ0J9fW5aGE5mPaszv+DYKlU1XLUW8sT9jeJ6Ydufg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNfkmDO6FOsouYueLQGVyN7GLT3n4V5G1VGJ1p2+4lbfOf/ssx
	x1wEis/Jyns7CiWg1BFJQaCUWQyeunZ246iA8Jys+XcHY11ZtZx2+X1lmubWp1D4lG+vOtViKu+
	B8BMNpzyRMPkWizp4/Gy7WrpwK9d5qi8=
X-Gm-Gg: AZuq6aLP7CqLU3SKT5oqJMECeeluDCLoJVZXotoYH+KromjqDZkkTO+t3g7jG9kpyat
	phdOoZRutj+g3RIB9DB+ELjJ7BUVzWZM9NDBe5w8WcQE06gsWG5LidCoiLQs4RYj8V9vVLxD3g0
	3tzFsVt0UCpeSbe+B/xhvVmAaekCl51cSKGlyoJ8IPf+t5NrpI38P1eFobSQr70hL69BpUmiu+t
	qFa4y5NRv7hdikfBhONGmJwr+UEYeV9Sq+gZvfwjwFCyCowxpPbJNzLPeXATZ1edA+7xRNFV6EY
	WL7Frli0imPk9MJxCy0H3qX7RfnUhfpBwQY5ee0Lsh6k1xIv0udoRVU=
X-Received: by 2002:a05:600c:6217:b0:480:6910:abd1 with SMTP id
 5b1f17b1804b1-48398b5d5c6mr3435595e9.18.1771371394920; Tue, 17 Feb 2026
 15:36:34 -0800 (PST)
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
Date: Tue, 17 Feb 2026 15:36:23 -0800
X-Gm-Features: AaiRm50S_8HbiTq-rHvY-Vu5YZbVnz6yG-KBkKAQGni1VF15QKHPJ6JJsJaTSsw
Message-ID: <CAKEwX=N+djRJ7QVYbvi2ziiWdPcpS1Z__wH2=mBef4EGcdNorQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42793-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8C820151F40
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:11=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Feb 10, 2026 at 10:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> > # free -m
> >               total        used        free      shared  buff/cache   a=
vailable
> > Mem:          31582         909       26388           8        4284    =
   29989
> > Swap:         40959          41       40918
> >
> > The swap setup follows the recommendation from Huang
> > (https://lore.kernel.org/linux-mm/87ed474kvx.fsf@yhuang6-desk2.ccr.corp=
.intel.com/).
> >
> > Test (average of 18 test run):
> > vm-scalability/usemem --init-time -O -y -x -n 1 56G
> >
> > 6.19:
> > Throughput: 618.49 MB/s (stdev 31.3)
> > Free latency: 5754780.50us (stdev 69542.7)
> >
> > swap-table-p3 (3.8%, 0.5% better):
> > Throughput: 642.02 MB/s (stdev 25.1)
> > Free latency: 5728544.16us (stdev 48592.51)
> >
> > vswap (3.2%, 244% worse):
> > Throughput: 598.67 MB/s (stdev 25.1)
> > Free latency: 13987175.66us (stdev 125148.57)
> >
> > That's a huge regression with freeing. I have a vm-scatiliby test
> > matrix, not every setup has such significant >200% regression, but on
> > average the freeing time is about at least 15 - 50% slower (for
> > example /data/vm-scalability/usemem --init-time -O -y -x -n 32 1536M
> > the regression is about 2583221.62us vs 2153735.59us). Throughput is
> > all lower too.

Hi Kairui - a quick update.

Took me awhile to get a host that matches your memory spec:

free -m
               total        used        free      shared  buff/cache   avai=
lable
Mem:           31609        5778        7634          20       18664       =
25831
Swap:          65535           1       65534

I think I managed to reproduce your observations (average over 5 runs):

Baseline (6.19)

real: mean: 191.19s, stdev: 4.53s
user: mean: 46.98s, stdev: 0.15s
sys: mean: 127.97s, stdev: 3.95s
average throughput: 382057 KB/s
average free time: 8179978 usecs

Vswap:

real: mean: 199.85s, stdev: 6.09s
user: mean: 46.51s, stdev: 0.25s
sys: mean: 137.24s, stdev: 6.46s
average throughput: 367437 KB/s
average free time: 9887107.6 usecs

(command is time ./usemem --init-time -w -O -s 10 -n 1 56g)

I think I figured out where the bulk of the regression lay - it's in
the PTE zapping path. In a nutshell, we're not batching in the case
where these PTEs are backed by virtual swap entries with zswap
backends (even though there is not a good reason not to batch), and
unnecessarily performing unnecesary xarray lookups to resolve the
backend for some superfluous checks (2 xarray lookups for every PTE,
which is wasted work because as noted earlier, we ended up not
batching anyway).

Just by simply fixing this issue, the gap is much closer

real: mean: 192.24s, stdev: 4.82s
user: mean: 46.42s, stdev: 0.27s
sys: mean: 129.84s, stdev: 4.59s
average throughput: 380670 KB/s
average free time: 8583381.4 usecs

I also discovered a couple more inefficiencies in vswap free path.
Hopefully once we fix those, the gap will be non-existent.

