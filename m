Return-Path: <linux-pm+bounces-7126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6148B28A8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EE1C21AD2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C22114F9F5;
	Thu, 25 Apr 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iq9a5Joh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1F14D717
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071694; cv=none; b=k5FBb0kel98p9o9EOP0VE2iKlkwcejIQBPZVC5JMDDMopQLn8Vm0Bz3Mqz4BUSP/EvgyngX3fgMm3LpbHpPi0KaTQQ38F75EEHVQ4UXiECkFmKN2fW9hkcjsR7CtykhiKot7pd5bqGEA3uzzeFTcvRjGb9L2VuDl76fcMD7fCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071694; c=relaxed/simple;
	bh=JeXz2/TFeNnXiSq/81VOk+f7TlrQg/8jpIhKlDJ3Qcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+2fXxGpNS810dUMbbg62jQbhiLSeVTaU6N1+w/0x0IxTpfIR1GxSZZgaXdktfrt48aD/90vr5yBNmIa7h7AbiPpJmNAzww1qJ90K8AHENjEe4Fuq0CmV7PqnzMdznCjjocgpCy2nzDhwx/z5o/QDpyqvDjAE853ISL51Y+z+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iq9a5Joh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51bae805c56so1574101e87.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714071691; x=1714676491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+CfDSUKDWMFi6696XWhw/F7Vcz9ViYAQl2uJokcaMA=;
        b=Iq9a5JohsTpZ1Plw8lZtgNq/zWMOnM/vDa6gZR988KJL3wzjPGq9S1AdIubOwOi8CH
         NPpmx9mtAibp77SJE81y/Z4W08avKFQ5qUZQ8IR2OfV8DUFBdPKD7igii1OzhoNYfDFr
         PzqrW1WJmyNn5Z5FOd5FWMytOdAVjucQnXWuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071691; x=1714676491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+CfDSUKDWMFi6696XWhw/F7Vcz9ViYAQl2uJokcaMA=;
        b=W0JkMbMvYc7V/ueERqEjEnXWJNx2pv2dENAFAWHRQrpX7uhLf17hHYWIb9nfdeFuWh
         e5NhPq+3Hg7rjlgrQBE9ePvNF5RsSdGioaPLyo6u3abvPIxm0yEcnnbGN7ZICjg37t+K
         TgRipO/knLD3tC4Fmv2NDXL7Kw2LzQp3Qd6eyiUHHq9ie0zOCmXNa8olhof4jEwlgrbi
         5UgFycmlMeLfmtgjejL4jTSqbcGghZonEYVx5UPTMvdQM2BbnqBdZU4uBKt49cx5z7D3
         FYVKe75jHoSCfdWhzzFgeQR5Aj9gtg+c80MiwJdEwsP+5EAvuNjusHX5vyJxjHJilDrD
         8/tg==
X-Forwarded-Encrypted: i=1; AJvYcCX0gtlSCa0MvXOiRThl7s3BYvpSYHQHGGBVxCNklTpK+aMIwf/LvFHNZKo+QrXasmTTphjwSNGhb5R3ssSGRgphtt0lh/TaUrQ=
X-Gm-Message-State: AOJu0Yz1aa5s1542EQ8wxZjVg+USUP33yRLWvq6F4SctgprGEqMpTL0q
	uhuOUvR/L9Q/boDgixR9D9RSQQLkuCOU8M16fjyhyez3khFwv65NzikL1s/LRNlf5b0b0YV9aHI
	db7Ir5Q==
X-Google-Smtp-Source: AGHT+IGbu/fC//FrI7fe8XcStRRe+Z8W0Z+AXDr8aDTY6ZLQRIdSgUxT5yGGS89QAPBsnaFgVODyJg==
X-Received: by 2002:a19:5e1a:0:b0:51a:f1bf:544c with SMTP id s26-20020a195e1a000000b0051af1bf544cmr169322lfb.52.1714071690669;
        Thu, 25 Apr 2024 12:01:30 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7c383000000b00570439141a0sm9435195edq.3.2024.04.25.12.01.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:01:29 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso1401395a12.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 12:01:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKfE6qhkcUfbTqzMAFNTsZRnri/BPeTh0Zym0jo8X4qIVUL2AIVdtAUKCmmvCaGl6HGPJSjWZ/fPdjhbzHywGRJOxS/T0Nnu8=
X-Received: by 2002:a17:907:76a4:b0:a57:b828:5f4b with SMTP id
 jw4-20020a17090776a400b00a57b8285f4bmr452572ejc.58.1714071688536; Thu, 25 Apr
 2024 12:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
 <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 12:01:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg2hknXUtxq8F7caSmbtRNpss0zhDwv505L25dfQBXDA@mail.gmail.com>
Message-ID: <CAHk-=wgg2hknXUtxq8F7caSmbtRNpss0zhDwv505L25dfQBXDA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> When that macro now has had TWO independent bugs, how about you just
> write it out with explicit types and without any broken "helpers":
>
>    static inline u64 MASK_VAL(const struct cpc_reg *reg, u64 val)
>    {
>         u64 mask = (1ull << reg->bit_width)-1;
>         return (val >> reg->bit_offset) & mask;
>    }
>
> which is a few more lines, but doesn't that make it a whole lot more readable?
>
> And maybe this time, it's not a buggy mess?

Just to clarify: that was written in the MUA, and entirely untested.
Somebody should still verify it, but really, with already now two
bugs, that macro needs fixing for good, and the "for good" should be
looking at least _something_ like the above.

And despite needing fixing, I've done the pull, since bug #2 is at
least less bad than bug#1 was.

                   Linus

