Return-Path: <linux-pm+bounces-7125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60808B289E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 20:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F61C20908
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEB15218C;
	Thu, 25 Apr 2024 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BSY/3kPU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF931514CB
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071520; cv=none; b=uNiBJrz2nR0XHSl2eyaT4SxAMegh2ypkuxOlmcI+oJLMmbyxsZQVnWeyG8P4cR+BxnmOrEAic2UUZL0VVxhfeFKNXShhd9PFvDR7a4x28Ye3ldgFyAywWdiimrNgnxtYt60OQFYjVoVhcJU1WjLSfHQ6TnX4AqsYhnPw0MyBQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071520; c=relaxed/simple;
	bh=OVpsYfA8Qvyh7CR1+bvLaN9uwU+c3vdVxNAvJVeMlHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqmbQIg9rPe5ZjmuvmpFVYbZefpikt4YnxdK40lya7jMkNXbLsBAfqKFYXyT4k3TVC+EUJabFqjMkKlCalvqz7pQ6piNb2EpvyILjwKfDFANq7FsxJviYQ0g9iNmKxlmbB5HGnUooqw4jwbn3Q9Za+SwqSwRwvhqEYRNZ4Udf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BSY/3kPU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso2067742e87.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714071515; x=1714676315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ce4eWZ96+PrDKbqu3JpH3mxBstfm8l4HTUGuvQBwL34=;
        b=BSY/3kPU2LDUUH9P3/zD/9Fn0Xs7RgJlwyFVVTiVSxRdtqDvpbHXquGVC6oD/ERSV5
         pqv62WfCZUkd5sr621/tTVVgo6uxruTv7Di9X04tfF2BEG5IvY9Vc7Plee6L67A9Ypf9
         l+OG7mpvBD91rqAjT85PVWegSoNe54g0DwfMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071515; x=1714676315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce4eWZ96+PrDKbqu3JpH3mxBstfm8l4HTUGuvQBwL34=;
        b=iDplZQNpLwqMjpN+crpHlYrUEDS4Iu3gl5S7qPQrlHQeQutjTCiBPrBEELhsAEZBqb
         93qxoMaHypztBhAdEA1djNFSBmQxjE9WoCP5p4lm4G1IGNkZP5m/oMvkHDB3JEKvBc2+
         aKde+mpy+1fkEZcig+2mtqoHVhWP3pPMDENteCiIk7WPUZ2E5ZSkB0bUutq9BxNKJo6Y
         VH6N+tdDVGZ8DKf5NhYGyavRz8+ZGn+3FcOBQJ4pLY1CgBSL/B8mg3de1AXVLKdjHWoc
         cQ0rbJmOtnECYgSSyouEz2cZ4sI5rIP5j8MJCFC1Sc+quYUH7yUjv79VcfCs7I+tVK6w
         d00A==
X-Forwarded-Encrypted: i=1; AJvYcCXWUyUDvkvM2+YVFUahuZ6PgLoMJxKBhFnCnqMLhOjiwvF5Cfs4ZHMfRPf27tbVlEu/oQC92Fl5z97ZVlcBG7SaybFbJRFz+8g=
X-Gm-Message-State: AOJu0Yzddie4jbH5gJxnKUCwLFEAfUttl/lFzOenPmt7FNMl/M0W0Amf
	zsE6i1LGaXoKEe88qdfULf15FxE+Ows0e3/zRbi9AxeFt8EbcVJGQUUgRBLGZGvdE0PvCCWzoZF
	8laEKWQ==
X-Google-Smtp-Source: AGHT+IGAXOGxyd7IoJnO6/dol8E/3JGcHk8yC0MdKwqh5jURP7JxaJShrtcuO6CYZ9Bl5MbpA8Q/Sg==
X-Received: by 2002:a19:f704:0:b0:51c:9d2:f43e with SMTP id z4-20020a19f704000000b0051c09d2f43emr174986lfe.36.1714071514931;
        Thu, 25 Apr 2024 11:58:34 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id n23-20020a05651203f700b00518a3f2e3dcsm2887843lfq.57.2024.04.25.11.58.33
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:58:33 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso2067690e87.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 11:58:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC4yPjy563DE2g6ZglIOe4V29565mxVXB9T1SUdp4NOL3pRAoSxhDrtYX4KHbZK71BQaU+um2vnfm4AfWOdRr3UuiLP7EqdLg=
X-Received: by 2002:a05:6512:ba7:b0:51a:fc86:fc6d with SMTP id
 b39-20020a0565120ba700b0051afc86fc6dmr218319lfv.22.1714071512772; Thu, 25 Apr
 2024 11:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 11:58:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
Message-ID: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 10:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Fix bit offset computation in MASK_VAL() macro used for applying
>    a bitmask to a new CPPC register value (Jarred White).

Honestly, that code should never have used GENMASK() in the first place.

When a helper macro is more complicated than just doing the obvious
thing without it, it's not a helper macro any more.

Doing

    GENMASK(((reg)->bit_width) - 1, 0)

is literally more work than just doing the obvious thing

    ((1ul << (reg)->bit_width) - 1)

and using that "helper" macro was actually more error-prone too as
shown by this example, because of the whole "inclusive or not" issue.

BUT!

Even with that simpler model, that's still entirely buggy, since 'val'
is 64-bit, and these GENMASK tricks only work on 'long'.

Which happens to be ok on x86-64, of course, and maybe in practice all
fields are less than 32 bits in width anyway so maybe it even works on
32-bit, but this all smells HORRIBLY WRONG.

And no, the fix is *NOT* to make that GENVAL() mindlessly just be
GENVAL_ULL().  That fixes the immediate bug, but it shows - once again
- how mindlessly using "helper macros" is not the right thing to do.

When that macro now has had TWO independent bugs, how about you just
write it out with explicit types and without any broken "helpers":

   static inline u64 MASK_VAL(const struct cpc_reg *reg, u64 val)
   {
        u64 mask = (1ull << reg->bit_width)-1;
        return (val >> reg->bit_offset) & mask;
   }

which is a few more lines, but doesn't that make it a whole lot more readable?

And maybe this time, it's not a buggy mess?

               Linus

