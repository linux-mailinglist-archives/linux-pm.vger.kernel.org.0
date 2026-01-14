Return-Path: <linux-pm+bounces-40875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618EBD205C3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 809043003BE9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1883A4AD3;
	Wed, 14 Jan 2026 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfHOSPSu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11739E194
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409661; cv=none; b=YYpAg9KJUEFtuN3SukGSpbAwHisesK4P294SzMsjgfG+byr3YIQZdSHdkC4Mf011DWHJgRW/X8ho8RYfysUNPku5V8uUtEMpQNBD0BMwlIhF3+Mz1w07O5WIThOqt8BbKt2BmRZ26OSup5ongmmaFxsDAunUMJ5zdLu2qKg1spE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409661; c=relaxed/simple;
	bh=AUswuB+yiLcJpnduZi+t9HGVDyDMoOn3BG/dXGXjQPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBBfyER5WmXR7Vq5HKLmulMRaOBjtbxMyVmDTugSBTX2hlR0krBokKqd9n8Kk62JHv3gbesKf0W8CZahTaR/IjziQVg2cIPDP/WNioBUaoFD6fTWJT8s55OGHuRmAHmYtcq3xbeqN2YI/6bxwtwZAZPXWES3D8J6shYEUlDstLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfHOSPSu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so15108196a12.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 08:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768409658; x=1769014458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KqwRJpxue33MOl5GGObv53v1MmSJ6VidNvLuqKaRC+o=;
        b=KfHOSPSuAZMU8Z3845AlzpZrFcqGBSugZFI+KBiVL8ZXMhncjiYPvpFc8v4KZfq2Ll
         oguNkBtBWHujbynnvSxx3uRIZQDMgQwtUmSgAHSrWfmt30klYDo7fznoThBgrgSlJ7Yt
         9UKbbGThx3LtK4t2UBp9liNOryjaEMS2wVonOzBTY08/Vfaljp48Nn+MxMV5fRdmg63/
         z9ZHo9Rco9zKjplT9gDQ8BBn5jdhF1EIaXkaRjXL2kz+fbGkIhnNh1tu41IfH3AfZ1NO
         nifGCLGfWyB55hDqSEqG0l97eDLCsDOeUZWqb4GZvmmU26sHJptLC0keLo1O6UkR7AC7
         PTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409658; x=1769014458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqwRJpxue33MOl5GGObv53v1MmSJ6VidNvLuqKaRC+o=;
        b=F1tRDtoCqMSwZZDzaEYZu1464ZsdvrmqaJSksgzkdDrJbeFEYmwG7z8+TibBZwbNMO
         laP0e4LWzrrm6e4oOWo4Fyo4TCS2yjJ6hvp6bPs2IIsnm2Z9IcGmVJW6aS4EE9cw7KLM
         gTeeBUxklYD8W1OS+rpDL1Ci1yzTa94OjlwNq7kAJf9NvbUxR33m8ThA1+GAuBO/CHV3
         /sqakzGYTtlPoWqUbSX3haSpjSLJ2vVh/Y50LvVx9Xk4hX7vgO1Z7X8toJ2DZKyV20H2
         JVpAp6Yso+iDxKhh409KagDowY1sx0JDtVjY/GOW1C5esLJ2+8xlue2GgMZBtiZ+nSeb
         CTyA==
X-Forwarded-Encrypted: i=1; AJvYcCUOHp5Zp4RUvF6ewB2sCXSMQ/xHPQcKd+P00dLnWsvudoOgmDBbKgj/Zxa90/JErL1dzPkLXIx7tg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49RoMgDFgjZnXifSCL+g5BI6nc6yWb9orCuUNKssbb/fCw4W6
	UAwlDeAq8KeHaH9ToekUlyveVFXrpIrjsRTB2MA9mDkMaM72EAUQ95EB+tXTdp0lmyliPr/Jled
	RF9eSJhdBIsSVl/fnM3P4MFxDrtXbXtU=
X-Gm-Gg: AY/fxX5nbpIDDmerhM80uZrLDBPLYSF3xUuiRCZ8pVfBEMdH+D4oEpyNN4B8rZAIhhO
	U/xIkYi5QDehGg6QJvJwGcDl77X/CbXP4altIonvSY+iOL1CMYVAG8fcfP7jv/RbLXKfAOzQ/up
	hf0bfTJkXF4YiRGFpUjxA8mShqlEX1J7DF4UArSapRBiyskSWKkN1ugn0Fwiv8SHWla8iPJg5D9
	TSmYQzRaUqH9FSk/1/a5rDW5F4t+x1wdQx3yVSXBOhlc2KToktdTHxfOYn7FOO0+yydHOeSeCwj
	h9Tc3w4GRok04YXwIAm/0o7PW9RH
X-Received: by 2002:a17:907:7f8e:b0:b87:6f2:a486 with SMTP id
 a640c23a62f3a-b87677a7f8bmr249654366b.31.1768409658230; Wed, 14 Jan 2026
 08:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com> <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
In-Reply-To: <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 15 Jan 2026 00:53:41 +0800
X-Gm-Features: AZwV_Qjn-RSslqq6wTqoEnFMFejeapaNcVrbMiSJKDsO_29p3k_5tRBK6xPtM6g
Message-ID: <CAMgjq7AUz10uETVm8ozDWcB3XohkOqf0i33KGrAquvEVvfp5cg@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007f60f606485bf5bd"

--0000000000007f60f606485bf5bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 3:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> The current swap entry allocation/freeing workflow has never had a clear
> definition. This makes it hard to debug or add new optimizations.
>
> This commit introduces a proper definition of how swap entries would be
> allocated and freed. Now, most operations are folio based, so they will
> never exceed one swap cluster, and we now have a cleaner border between
> swap and the rest of mm, making it much easier to follow and debug,
> especially with new added sanity checks. Also making more optimization
> possible.

...

>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Hi Andrew,

Is it convenient for you to squash this attached fix into this patch?
That's the two issues from Chris Mason and Lai Yi combined in a clean
to apply format, only 3 lines change.

There might be minor conflict by removing the WARN_ON in two following
patches, but should be easy to resolve. I can send a v6 if that's
troublesome.

--0000000000007f60f606485bf5bd
Content-Type: application/x-patch; 
	name="0001-mm-swap-fix-locking-and-leaking-with-hibernation-sna.patch"
Content-Disposition: attachment; 
	filename="0001-mm-swap-fix-locking-and-leaking-with-hibernation-sna.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mke8ymuo0>
X-Attachment-Id: f_mke8ymuo0

RnJvbSAxZjM0ZDZkYmUzNzhkOWZlMmY0NTQ0NWZjNzkxMjc1YWFlZGI4NDgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLYWlydWkgU29uZyA8a2Fzb25nQHRlbmNlbnQuY29tPgpEYXRl
OiBUaHUsIDE1IEphbiAyMDI2IDAwOjE1OjI3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbW0sIHN3
YXA6IGZpeCBsb2NraW5nIGFuZCBsZWFraW5nIHdpdGggaGliZXJuYXRpb24gc25hcHNob3QKIHJl
bGVhc2luZwoKQ2hyaXMgTWFzb24gcmVwb3J0ZWQgdGhhdCB0aGVyZSBpcyBhIGxlYWsgd2l0aCBo
aWJlcm5hdGlvbiwgYW5kIExhaSBZaQphbHNvIG5vdGljZWQgdGhlIG5ldyBhZGRlZCBXQVJOX09O
IGlzIG5vdCBoZWxwZnVsIGJ1dCBjYXVzaW5nIGlzc3VlLCBzbwpwYXRjaCBib3RoIGlzc3Vlcy4K
ClNpZ25lZC1vZmYtYnk6IEthaXJ1aSBTb25nIDxrYXNvbmdAdGVuY2VudC5jb20+Ci0tLQoga2Vy
bmVsL3Bvd2VyL3N3YXAuYyB8IDIgKy0KIG1tL3N3YXBmaWxlLmMgICAgICAgfCAxIC0KIDIgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
a2VybmVsL3Bvd2VyL3N3YXAuYyBiL2tlcm5lbC9wb3dlci9zd2FwLmMKaW5kZXggMDM2NDg5ZDNi
MDFhLi4xOWVkN2JkMmFkY2MgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9wb3dlci9zd2FwLmMKKysrIGIv
a2VybmVsL3Bvd2VyL3N3YXAuYwpAQCAtMTk5LDcgKzE5OSw3IEBAIHZvaWQgZnJlZV9hbGxfc3dh
cF9wYWdlcyhpbnQgc3dhcCkKIAkJZXh0ID0gcmJfZW50cnkobm9kZSwgc3RydWN0IHN3c3VzcF9l
eHRlbnQsIG5vZGUpOwogCQlyYl9lcmFzZShub2RlLCAmc3dzdXNwX2V4dGVudHMpOwogCi0JCWZv
ciAob2Zmc2V0ID0gZXh0LT5zdGFydDsgb2Zmc2V0IDwgZXh0LT5lbmQ7IG9mZnNldCsrKQorCQlm
b3IgKG9mZnNldCA9IGV4dC0+c3RhcnQ7IG9mZnNldCA8PSBleHQtPmVuZDsgb2Zmc2V0KyspCiAJ
CQlzd2FwX2ZyZWVfaGliZXJuYXRpb25fc2xvdChzd3BfZW50cnkoc3dhcCwgb2Zmc2V0KSk7CiAK
IAkJa2ZyZWUoZXh0KTsKZGlmZiAtLWdpdCBhL21tL3N3YXBmaWxlLmMgYi9tbS9zd2FwZmlsZS5j
CmluZGV4IDg1YmY0ZjdkOWFlNy4uOGMwZjMxMzYzYzFmIDEwMDY0NAotLS0gYS9tbS9zd2FwZmls
ZS5jCisrKyBiL21tL3N3YXBmaWxlLmMKQEAgLTIwOTYsNyArMjA5Niw2IEBAIHZvaWQgc3dhcF9m
cmVlX2hpYmVybmF0aW9uX3Nsb3Qoc3dwX2VudHJ5X3QgZW50cnkpCiAKIAljaSA9IHN3YXBfY2x1
c3Rlcl9sb2NrKHNpLCBvZmZzZXQpOwogCXN3YXBfZW50cnlfcHV0X2xvY2tlZChzaSwgY2ksIGVu
dHJ5LCAxKTsKLQlXQVJOX09OKHN3YXBfZW50cnlfc3dhcHBlZChzaSwgZW50cnkpKTsKIAlzd2Fw
X2NsdXN0ZXJfdW5sb2NrKGNpKTsKIAogCS8qIEluIHRoZW9yeSByZWFkYWhlYWQgbWlnaHQgYWRk
IGl0IHRvIHRoZSBzd2FwIGNhY2hlIGJ5IGFjY2lkZW50ICovCi0tIAoyLjUyLjAKCg==
--0000000000007f60f606485bf5bd--

