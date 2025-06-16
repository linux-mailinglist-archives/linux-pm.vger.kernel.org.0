Return-Path: <linux-pm+bounces-28791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39222ADA9D1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 09:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D06165469
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85320E01A;
	Mon, 16 Jun 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/BLPgu4"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437272626
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059968; cv=none; b=hZJuCwpT44jMYAxqfdi5yCDzR9ZcwpFy22uWYLStjN41zuq0HYoHmfPVyHxON23Vpwxo8qyOp7MURqIjXFA2tsTYCVlDORQ7r8VCTIB85M4pVI7weDOBnjdCOROMMdW3ZJmHc1Ors+VbBCgJ8fJKmWaT1YD80oZCbiMe9dx8WAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059968; c=relaxed/simple;
	bh=kZgynoFkUzybApfkLZERpY5+G09BNESS4m8vGhKDDwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dj9+rrMEpLN/rar5GCmTHLbdYjub0o5VtLXpAdPm+L4Qa+9/FygBQ+K3g25bkEVLAufF2MZx8jVH9ozk7+obdX7rP2KbLH7r4hfLFy4ZQDXKiCaQUkOGJsgLq1EZcOz9ixMFEbjBhRME7mlHUKaZQypugC1dYfw1xre5o980Dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/BLPgu4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750059965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Okj/kP/PSDRuGeZw3t+DuAGitLEvOE2IEooVVukBKUk=;
	b=Y/BLPgu4+kBH83CRD4EwUWIXTIJalbobCW8qZ/1KknhsbNq9adIDVnnhkfnrgYXfVASzgE
	aAKziQjIq5moEV78tCGhWqditZpABYQr+9isVVhniO8Jju+aaQrMF2sxy6ja70Jn1Sqt4W
	SpB6UTZist3566YVozpuIGVGppY90kE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-90PTxdmkPuO_6NQvw-yzKA-1; Mon, 16 Jun 2025 03:46:03 -0400
X-MC-Unique: 90PTxdmkPuO_6NQvw-yzKA-1
X-Mimecast-MFC-AGG-ID: 90PTxdmkPuO_6NQvw-yzKA_1750059962
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f6cc5332so2427121f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 00:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750059962; x=1750664762;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Okj/kP/PSDRuGeZw3t+DuAGitLEvOE2IEooVVukBKUk=;
        b=dxAxN3BxRdVsbamWkyrq2tZslTiFfYnWV9uE3EqlV2U/rGOsGsU9v7IvO+GjSbSVnT
         8kDMq8HjZyHcnZ6qcevibfldC+cAxt7+T2H/z9mowPNJdf2So33RO989cz5p/cYj7eBW
         e1LN3FfVgICAs3pmOvgkH4jkvcgBGcC7YyvV/QhyffNGmtb2pszWDd0kv8PqJwRh9J0F
         z5HXvnM0KFZm0bmC2oU2uMHfRa0VC3H2F9hDO6m+psoVlNQrxaGFMQvftFEU77fuobPK
         BiLwZH6kDmvIFQgfTXi7jHAhWkohgrVdDsSgXkmn+KyLGKzx0T+YHNqz/wn3Kr5SXRpu
         0E1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDv4iZQkJMKQ2lu6iy1DIyH+ve0Eq3bZak9iZigC/cDq/qY2ljHAp3+sA5didFRIGERht8MzH0jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCoAZd3S6QKQaknIHeaYF29TOjlsOisHRh3BZcGbVLo8q0K6i
	IakarIQhvWSq+D4DfJVD+dkdtuvqcxTzW8J5sEwVWKglPxtme/4X/Pmfy+G4EfI7ZXhgrZcln3V
	0aiubLPFmgQwSrCov5pebHcXnpD8PZ+yY0/np1JUK4wRs5VnpmfrtR+CiecO2
X-Gm-Gg: ASbGncvcnuuGTZO47RA07t+GiYaI7uAXT1EHn21DO0kpmIsFouoPpohQn7I90KjH93O
	TFv7O3nzGITYbrBcVKu31l/gvAyRn4VyE7rhdLEYBQZuRFwzHIy5s7Zz+4Kiw46aunPuA40xIeE
	dhqd6f0KWhMJ5qn/j2d2f8weF13ySpwieZid4RqlvdINVx86vUDE0jpyfhPPzvDpeE+KhXqoIkb
	bsBBkx0oWBPajzBp4oZJJvzzCAQvIFWDAnGBFXwnaodnOEd6Nnyex5LJ6zxj+2N8W+l+OYnxCww
	HVnGPsssu7FPu1yjIv61olho8dUZDGGdyTAIZ1f2EYOTRnLrhOsAkA==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3a5723af27bmr7422408f8f.46.1750059962074;
        Mon, 16 Jun 2025 00:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfT1PvrLZiG1vdsOyCoELGBFAAk5XwE+7O8aiaXoA5qsHPUWS4oVWcsTeOdrEXYCWYcK0hng==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3a5723af27bmr7422378f8f.46.1750059961625;
        Mon, 16 Jun 2025 00:46:01 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a9f2.dip0.t-ipconnect.de. [87.161.169.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a60d0fsm10151403f8f.22.2025.06.16.00.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 00:46:01 -0700 (PDT)
Message-ID: <775aaf10-3d19-4d5a-bf2b-703211166be4@redhat.com>
Date: Mon, 16 Jun 2025 09:45:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, kees@kernel.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
 <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
 <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>
 <aEvNqY5piB02l20T@tiehlicka>
 <ee1de994-e59f-4c6c-96f3-66056b002889@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ee1de994-e59f-4c6c-96f3-66056b002889@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>> [...]
> In our test scenario, although new processes can indeed be created
> during the usleep_range() intervals between freeze iterations, it’s
> actually difficult to make the freezer fail outright. This is because
> user processes are forcibly frozen: when they return to user space and
> check for pending signals, they enter try_to_freeze() and transition
> into the refrigerator.
> 
> However, since the scheduler is fair by design, it gives both newly
> forked tasks and yet-to-be-frozen tasks a chance to run. This
> competition for CPU time can slightly delay the overall freeze process.
> While this typically doesn’t lead to failure, it does cause more retries
> than necessary, especially under CPU pressure.

I think that goes back to my original comment: why are we even allowing 
fork children to run at all when we are currently freezing all tasks?

I would imagine that try_to_freeze_tasks() should force any new 
processes (forked children) to start in the frozen state directly and 
not get scheduled in the first place.

-- 
Cheers,

David / dhildenb


