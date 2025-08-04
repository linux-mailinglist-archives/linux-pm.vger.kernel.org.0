Return-Path: <linux-pm+bounces-31915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20349B1A541
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864041885BA5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803B1FFC48;
	Mon,  4 Aug 2025 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7CmMmct"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBF20A5F3
	for <linux-pm@vger.kernel.org>; Mon,  4 Aug 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319047; cv=none; b=cF62trEF7liPp/mWeQWMHTUob+1WOVZeS7/voW8043Flm/HsQdlmXPhpfplJrJAL1u2IopVYK1MHTz8RU2TN4Jq8rFEi6/1JHzeE9KyubrSIzWXhRKUmzC+T+/KoP+xeleTaMkyEejPLaeunINZ82AG4CBLQoOy6RHKHtyqQf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319047; c=relaxed/simple;
	bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVuwaLKSxZ63o2wAnHxeuRRrYktCp1ZGl2h74gu9+kjTYe3oIIDs56rVYuUyBI0YIp/stXqC05A/YO5hXh97tLNjdcF+Q7xw6oFSfDV/NlbsEd8w7QynsFQvomRCDk6SLmuIDBCDnbYfcGaw3qgWGNjda7HT4POO2t3HZnr7DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7CmMmct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754319044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
	b=O7CmMmctRo8TFZp9kSQeC6rDb/zMSZ0HCHtbqtVv/qprOjythyKSwsXPkdGKeC+prscCG/
	iPvAZr3GrJvnAGlgdvZL1vLCszCYW18ffDvPJgI81KeCyUBP4qNSgYJg07OJPuAKMc/aCW
	n6sAfIZsr84pmte4/ictBb0pPG34+kQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-FhsryMZhNiSaX7kxThM8aA-1; Mon, 04 Aug 2025 10:50:43 -0400
X-MC-Unique: FhsryMZhNiSaX7kxThM8aA-1
X-Mimecast-MFC-AGG-ID: FhsryMZhNiSaX7kxThM8aA_1754319042
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7961b3c82so2074086f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Aug 2025 07:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319042; x=1754923842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th/zbNG2w/sGAVRFlv12HJ6Li/jSTJBgQ6X2ZZll/S0=;
        b=uwFzlx4V46KyKxvFieTv/sRCWTt+pRVHzPM5UfAuUWT6Tvap9lCidY+7MqCyQg4qYy
         jGYitRG5KXDfLDODiKZZIOHqRBqkVXdQ1VL0bjX+Qi+PnHztecioRpL9V/N5IqkUF/Rq
         KM4QsrtTtIGAeBwzvrBaaHsTV9DmEpUgaeoI9pUo6gM2eAw6Rez79TF/2kFsfaO1FGs2
         uSg09D4/SrktJtuIGxONWIGo81iLlEwljMKlTxAY+dBmuljyrJJ2HmdY7NguoqJYiNi9
         OdMenyRrK+dQZ3ADpUiFX8mhiIIIPvdEbIkW3dgCKo5NjfH6Ac6SwmtDXTq9BaBpD5/a
         N7PA==
X-Forwarded-Encrypted: i=1; AJvYcCW/A2v/qdwJM0OwHvSRMFMCtOii6c3YCvMaGHgz98p8T2dxDcJg16SL7heGAuYW9M4hTeywnmDy2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lYk0Ra6SbbieKlqtXNRVtSsg0oRCLviUTWBdvbR67ywbCdNJ
	zTIlY/oKBC/50rUhy4nlM+zDt+Z+Gz8TOvsValqpl4EAEZZ443ou/5Xm5rLLTT/mcmI7ffDg4qy
	G/jT8mFasLgIFQ5L5f2UPnth4ZFYt6i838d85bmsrNg2KoEEAVZrvAF8+p9o59SeTovS25njS4s
	enGEkTuRsQi6FY+cObSKFvbZve7TL0k/VZ/+M=
X-Gm-Gg: ASbGncs8bDzPax5Zch/wYPyxVXrJ0OZuG1249EPK+mv9jRE7FkqoHOd2/ZiEJ6WrM2x
	wQ+qaCcjwQuig3/cgFC7ecdPbgF7wjJtEQ2aLeUFyTS5s0pR7Y7u2Qrq70ocd3XNOsob3mp7H3X
	5eup6/3MI+sGMIxR/yytNP
X-Received: by 2002:a05:6000:1788:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3b8d94c1c49mr6701549f8f.34.1754319041935;
        Mon, 04 Aug 2025 07:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgsw4pwEJUoqykoSclSWi0JkSR9VtvKkMXz/zduARm+hjzykjvBGRpvCt0a+Ds377veRWW/i7OVVOUhVwFvkM=
X-Received: by 2002:a05:6000:1788:b0:3b7:94c3:2786 with SMTP id
 ffacd0b85a97d-3b8d94c1c49mr6701520f8f.34.1754319041488; Mon, 04 Aug 2025
 07:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
In-Reply-To: <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Aug 2025 16:50:28 +0200
X-Gm-Features: Ac12FXwltMgUzEEB8nqMLRA_D51YfOsfFkH1rt4nc_9cVgH_FR6V2EdEIAFZooc
Message-ID: <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: Andy Mindful <andy.mindful@gmail.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, ville.syrjala@linux.intel.com, tglx@linutronix.de, 
	Christian Brauner <brauner@kernel.org>, Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:57=E2=80=AFPM Andy Mindful <andy.mindful@gmail.co=
m> wrote:
> Double-checked bisect, looks like I've have found broken commit:
>
> > > git bisect bad
> > > The merge base ba5afb9a84df2e6b26a1b6389b98849cd16ea757 is bad.
> > > This means the bug has been fixed between
> > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757 and
> > > [1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > > 61da593f4458f25c59f65cfd9ba1bda570db5db7
> > > 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
> > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757].

This skip is messing up the results:

# skip: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect skip 0dd3ee31125508cd67f7e7172247f05b7fd1753a

and there are still 3858 commits in
ba5afb9a84df2e6b26a1b6389b98849cd16ea757..{1b1934dbbdcf9aa2d507932ff488cec4=
7999cf3f,61da593f4458f25c59f65cfd9ba1bda570db5db7,ba5afb9a84df2e6b26a1b6389=
b98849cd16ea757}

Any chance you can get 6.7 to work and restrict the range further?

Thanks,

Paolo


