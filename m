Return-Path: <linux-pm+bounces-36799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B749C07947
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796254017D5
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD334676D;
	Fri, 24 Oct 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK007PVk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6618336ED9
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328212; cv=none; b=Ob8/FJ0jZ0dZBKVU5NWQRNxyPpBVy0w6Sg4lr3Af2A7PqTg7K0/6bhlxvwzH/+ZlxHcBXpPwV2TCxEuIWbUBcJnhcnfd7+B1mNEF55syLWBfWh4tvAAA0HVRPCfcHBbi440HNT5agUP/10F9h7SfxEqvT+6FLOeGWH1Di5q18KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328212; c=relaxed/simple;
	bh=Cnr0WNctFG8V6FmmOcFwsBfOOmXZZvAjIfyVaJhKdXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWA/kC/ZSOlMZzB82old/VA+Sgi+9LKCGkIBC0hO/hgEdbnJU4KhWlFuw+YNAKO4p7HMMbO9ze+ek6jobPO+T892KkPBuSniaRBTi/Tn/ZPGI67g989kOpioGUUQ+zZ7N9JSqV/iCSy0kIJdrU9S+Hv4rX/k/o9migcFwA0DVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK007PVk; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so477445166b.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328209; x=1761933009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0tKDIn8Dd62bIobWa5FrOxCPkfvj/PGwj/fjdmIbdAU=;
        b=bK007PVkPKuygh6L7DV1dF+8BZU4zRt6yQtbZpcLBMiyQD8qZlyosQLgI1pgt94fFQ
         jCAbfQAKnCP39z1oZv/EAQ9iH6yab4cRP7WquVjdBAx5mf67bIWy2WTWoXEecGLsSaX9
         neLpKRUdQKMQwoCnbXD/dgwRzIE9lLzOsWYq2eAYdz4bz/LXhsxjy1HiiNCkGHn09N9T
         Mys4kh1gQcRaQ7JLQwOSQ+GR1pG58jhX7t0OhwAvjt8WV/u0+ZbcwiN4mcXYkXZWhBd2
         67A4efD5HYUN5yiZFa2swZtMR7OYxcc9LsaBoARhNI0nJENu/T7BrGUY2i0FHQP7jnxz
         FgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328209; x=1761933009;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tKDIn8Dd62bIobWa5FrOxCPkfvj/PGwj/fjdmIbdAU=;
        b=qRoKPtgK/mNAigYNpGMMlN0MEXdGL47SUHaC3BgQLhb47wmHgQh57RC/0b1tu7EERY
         +99daQ1iKarf1l76b9/QGQP41OYTtHW4IlqEQoJCSn7mlldU8dmv9OQ+2KWMlOhJBUiP
         p0il0lGjkIAlJ3XYig3aiI+c/EStsdVMkC9Z9ccJyDSK2qNXPrKRU1jqzzSmwnj4DjiA
         Qikb66M8L2Bs0xmoJNF6+fzNeazC5KQ+PKcoq6zSUz3yNU4pr0ySRC5CqF7hQmFyZqT1
         6GqFmtj3pangxAII+3RzVBX4W4l7sP9hAxaU6ZIbg2QD/7ZQ1uSOROZByzjWxeQ7ltMY
         rk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk4dXCSAXO+UwzhzhB3tlS1QWNuTzCPFrbzXSH/FRr2gh/hMlQ97zWebfFU312iU4u9FUcclt1gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNl9haES5VBOAL3cgXZpLhpx7QqOsdgdLs7DklV0olMfkrt5D
	vH/czeXvepILvoa9oO5PtFVAzx9UpqQjrTyvi72hbwl+vYLdpQCKaXuW
X-Gm-Gg: ASbGncvHoOGGho2V1Vgi5igL5HALsbLs13aoTxa84LMcMA70LDkJ+zGMY7h57lc/Csk
	FPBtbGdjmUbG6FCYhezEQ6MK6jqkFyZ5h+xcCvZi0TBAUEUI8kSgTb+DLcioWLwSHbuc+TgJAP3
	9RiJ4RYrCrEGJzvIr4w/2oUYQY9l9ioUndYoIEYuJCAqlU/BkTUjKUng0Q894H0g0s4DsYoZgC4
	j/KBbLbbdQ9EANCh2X2gEZ+OU77XxyhwMoayDuyp5tMMVN9h0ldhxG0zqViQ1//15SxJmMsAmkx
	+uMSSWYJEzo6jc2sNMEDsp0ZzE2arKeyIdlruo9lWIfGMZFhLCBB3qrwKuqxuYIlyUor2nPcm5A
	6B+wTpnI5kNn5L5mXsXgf3f/UgenxSkPBIdRWwcLYqe89vaAhFOQU3ht4TaINRbmqiiz4/hiyDG
	5Ix9LZvxXh4BO49G9T6kmR76OB0L70UWmnGWZvQH/k
X-Google-Smtp-Source: AGHT+IEHVSSj7rXjwYMoHcZH9vR/vm/UDZA+qYlFM+r0okKL4IfHGOhTECkjaHomhCRDjSe3Dq8uEQ==
X-Received: by 2002:a17:906:ee89:b0:b47:de64:df26 with SMTP id a640c23a62f3a-b6d6ff25f61mr303261366b.35.1761328208958;
        Fri, 24 Oct 2025 10:50:08 -0700 (PDT)
Received: from [192.168.8.101] (37-48-18-87.nat.epc.tmcz.cz. [37.48.18.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144e4acsm585057066b.63.2025.10.24.10.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 10:50:08 -0700 (PDT)
Message-ID: <5e0056d7-3550-4c40-a698-c09535d32bb2@gmail.com>
Date: Fri, 24 Oct 2025 19:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work
 (how to get data redundancy for swap?)
To: Askar Safin <safinaskar@gmail.com>
Cc: Dell.Client.Kernel@dell.com, brauner@kernel.org,
 dm-devel@lists.linux.dev, ebiggers@kernel.org, kix@kix.es,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-raid@vger.kernel.org,
 lvm-devel@lists.linux.dev, mzxreary@0pointer.de, nphamcs@gmail.com,
 pavel@ucw.cz, rafael@kernel.org, ryncsn@gmail.com,
 torvalds@linux-foundation.org, Mikulas Patocka <mpatocka@redhat.com>
References: <a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com>
 <20251024163142.376903-1-safinaskar@gmail.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20251024163142.376903-1-safinaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/25 6:31 PM, Askar Safin wrote:
> 
> Also, I saw patch, I will test it later.

Yes, please test it, you can ignore may previous comments as they are irrelevant now.
Here is the link to the mentioned patch:
   https://lore.kernel.org/dm-devel/03e58462-5045-e12f-9af6-be2aaf19f32c@redhat.com/T/#u

I think that the issue is clear (as found by Mikulas)
- DM device (dm-integrity here) does not receive the FLUSH command here.

This would explain all issues you see. If the patch works, it should be fixed in stable kernels
as it impacts other more complex storage configurations.

Thanks,
Milan


