Return-Path: <linux-pm+bounces-20795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B0A18E96
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 10:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2607188133E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94561B87FC;
	Wed, 22 Jan 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNW6GM1y"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E45F192B84
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539138; cv=none; b=NWOBw2KRhWuBuFznsyfQ/s9McDDs4wIxhvPidsuYnXWbfW7eRXWOl70BMy7zd9/CYgJMmcqK6emDi0w9ElCXgCCeIlmKGog86M6yYYUkE81lV02z9vtpQxoxJo8hQvIiApXdQY6JCAHA9104fzlLqYhsyZjmcrDCy9nC3YrwQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539138; c=relaxed/simple;
	bh=PbZtck3Ww9NI3Jmz6UqmAMFTQrT+vXacf5H/xpbXfng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ma6mt5Zw/iJq4GhNA9f1N+pfUtRnQcKuKZkorwl9Q9X8IQtt4tqEv1hTxx3ZwBy09CCb1JBLAymoH0+NcsTPxQ17MMoPn3hMNOK92DknoBRKzJr02/QiqQxgGK9//jVrbPKgWphfEVT8+FjP+1/0vW9aN2T03fjS4dXA+qZuqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNW6GM1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737539136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyCjRrkbGde3kvq5V4txWDKrLIctP6FAvSzHNKivVTM=;
	b=BNW6GM1ypiUQ3ggy1OfTq9uFhMjC1J22ro+64agm0x6qhjTlr4L3D+iEPH7djogJyagTws
	N/duy6K2aGZKHkpzP361qVf3ptlJycfn48lq3Glun+eEAX0swUlg0+RbTxGhd5ooHZ76DE
	ApDXiNTDPUUsQoS9p6Dwi8WHAcr7Tx8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-CKuIU6GvN_iFV7wL0Eq6zw-1; Wed, 22 Jan 2025 04:45:34 -0500
X-MC-Unique: CKuIU6GvN_iFV7wL0Eq6zw-1
X-Mimecast-MFC-AGG-ID: CKuIU6GvN_iFV7wL0Eq6zw
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo47595305ab.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 01:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737539134; x=1738143934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyCjRrkbGde3kvq5V4txWDKrLIctP6FAvSzHNKivVTM=;
        b=itEBzfogxHRVgnUpSM9aRPserhv6eFNFbHeCqPciB9s46A5flBjVWe+YZBTZiStJpp
         IpZgLAAhu6Ph+CVUFOxGcKdo9a2G3EBT5auWjY6JdVgmqPfvirRimax923yTXXf35JXp
         vPBvjHufpusMq+1aVTFKtFdgnUGoJYSvGevYT9KjvDPz/12YDt6lKgR6yBuzWyyspXvZ
         mwV+c5l+C2E4s8me87XbCl0QgVeI6mAUs02sGVCxx260TD7J6oNDkyJ8UPgDUiEcE2y+
         IWMTRwBsrbhxdsWTdDvcPpNXmfuvaRrWosY8lkX2Tps82N/kex53k1yo4jrMZLB8t9pB
         VAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ekVYKVNqsikbJfwDNSB8GAGswJYcju505QDgDFgy23vkY8h5gI5uoLlWu6jmnvWNnnTC0BW+Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrosWVUOOe8YdMfnApXOXSfj43fWMHjZcEkWp4VPEnlmaV1kS
	Ow8RKW8OEQ5HGZCuc6BqBqiSu+Sb2vwjHf+Pkeii8ZbVZvCeLHNxX3qUv4JBou1DCgUwv6nRmAP
	r+muy9PlYXKjb39awpZd4wci+xMRk2Bb72YCKkpu+7/y76G/R9AnFpEk1AZ5y6C5gdfPxvHByXz
	gnwe5M6g3gfD/Kio/7bSkFEI+rRiJ04CM=
X-Gm-Gg: ASbGncvUABoTJbQeU5aXP/2XOKv1rXof15V3NtfZ9HfRomkYuq16sTdksFMWkXQgL7E
	uDVI25WV+6j9MymeO47ymKKdxQu7B/U4dWvlfB7ZNMm1M7KjhE2jU
X-Received: by 2002:a05:6e02:4708:b0:3cf:b62a:d38b with SMTP id e9e14a558f8ab-3cfb62ad548mr6839275ab.12.1737539133950;
        Wed, 22 Jan 2025 01:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIPD077b4G8AkO2RvsoOP8ZsRfpujjR36pn01SrQFGxp7KGByKkBoan7/VXdsRXY43BKX2FEh2Wdm8Pbn+dpI=
X-Received: by 2002:a05:6e02:4708:b0:3cf:b62a:d38b with SMTP id
 e9e14a558f8ab-3cfb62ad548mr6839035ab.12.1737539133320; Wed, 22 Jan 2025
 01:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z4WFjBVHpndct7br@desktop0a>
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 22 Jan 2025 17:45:41 +0800
X-Gm-Features: AbW1kvYNw_qRoZSbVWcaArR-_IblaJucJ-H4UePBgio9Q2kKLmrwRXL4Nk8Joco
Message-ID: <CALu+AoQhCjUPr2dnYdN751dyUgNUpyx1HCfyztF5GaP3QRzibQ@mail.gmail.com>
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
To: io@r-ricci.it
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com, 
	kexec@lists.infradead.org, linux-pm@vger.kernel.org, 
	akpm@linux-foundation.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> running Void Linux, with the following commands:
>
> ```
> # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> # reboot
> # printf reboot >/sys/power/disk
> # printf disk >/sys/power/state
> ```

Which kexec-tools version have you used?  I'm just asking to see which
syscall is used for loading the new kernel.   From your bisect results
it seems kexec_file_load, but just a double check as kexec_load and
kexec_file_load use different sources for building the e820 table.

Thanks
Dave


