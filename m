Return-Path: <linux-pm+bounces-3901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F865854763
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F272B24088
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C114297;
	Wed, 14 Feb 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksRL3MzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12D199AB
	for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907322; cv=none; b=BUSbsbj79pJm8dan2sujDw1cc8Rqh23M3FN8J4N34maY8iLCVDStGmoiWOc79tMm4QaM1svXntzefAn5yeYNxZvasqyiFZtwR7AI/nBIFzwCCv/QNtdThz+awQBnxBvlso0vrxfhCCTyOrCJKuZ0zHLL4Jil/4+bWSkfW26rV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907322; c=relaxed/simple;
	bh=Fsio90MCTcJobx/kjsKS9/65FS/cnF5natMw+uTBE7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDzhSoUsFkACYB72bck3EaODZN8o12UCOTEx767isACXyfIX6oJNi8X1tbFOwiusSAL7VPaI5Loyz0XlZdn57mJZ7Qv8j3pF4NOaRgWlhoS4559ebP3r5vrSGmFYoYiIKkxhrmJcyDtL/EzJovoB213ol8F1zdt2OxPPX6OXuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksRL3MzM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33cda3dfa06so986208f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707907318; x=1708512118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOZ3NQSNTdxmjncsYgG8hdi7Xq9Y2E4kScScNugHfyg=;
        b=ksRL3MzMZt6USIOuXYhzWIwbYE3FI1foGubXdHBtPVCcsQlPzZuYcn8OWAXQBx5+f6
         iaIkoLnedH26JqOBsLQ/A5dw8zsL6Bxo4m/iUQf4YXTQ87xzXZ04TtbL4/s5EvMxZcIE
         FIX2D7BgfBDdXi7fuA6SVujVHNFBeBEw4nGBE/mMGAnZJiVBM386qTOvhiywlkKNZB1J
         wtmpgzOacMPDroq+I4kkEuRnxf13TQbWtiGe5WGvrVI9ud5uZSfKqbxjphJFFTKUBpGA
         /xaqnVfMesn5Tnxox8O07MrRP9NsKPU/KLZnuh1A5sftcRQ8ZnaJ8/WzV/AZ4dUWdcgc
         BSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707907318; x=1708512118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOZ3NQSNTdxmjncsYgG8hdi7Xq9Y2E4kScScNugHfyg=;
        b=FRENkqgeiOKEJNqf0d8VCL/IkYU33iQScovdkbME0rgYC244bZOU7K7eOigLy2Awr3
         OwCsvWHqAM4v0SsflScJE5XlMtya+BvX5q7ACEd53z5nKA9pmanbRrBcTGZTqW/5DzZP
         55Z0FiJ9YWKoyD9SblAEu1HEL1qjKs8X9sxehZIycwpARm/y390UFSXwcvJjWefSQouH
         jxlK1ItcgnJjVyLsJsADCQ1ciJU/dbhxN3NMy0suflhkthvB5/nNF4YbNhgc8e9VNKKy
         JDQoxVq4U8XAMicJDvBkRc8cctp30Atg/kbkvEGOpHCsepRagw3TSOHsq08dQNQf5dlb
         XOwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe0MC0jUsaHGcT/ZbZk8sKCi4TEMeVB5gxtPOgdlm8mXh9EOlxzdn/baFhMsVyAcV9j4rLVfHS/1fkrbHHRlGRbQt/L+uX99c=
X-Gm-Message-State: AOJu0YxvjAY0zkQ8OhtNDEEK8PFELFYOyDWz2DIpmnUG+hvq2Uq6gjr/
	62LOlCcvceHMOXIFpJcEi7ZLVDMynABz1AZkHL73ZsISYEx4+pon/vS5VegwK/s=
X-Google-Smtp-Source: AGHT+IHFpS8luZdfBGUJZwl9gb+mhUEvvqFez76v07DcEI1qb4dztbhpmdVGzfXAYFAdApCiUzJFcw==
X-Received: by 2002:a5d:420a:0:b0:33b:8782:985a with SMTP id n10-20020a5d420a000000b0033b8782985amr1212002wrq.21.1707907318435;
        Wed, 14 Feb 2024 02:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWZUWRDED2uEHIfFV082ydqvqAB/GYew2iGk1VeE0C2TKI6XMT98+GgA8qWsCLOlqBXgRWjdA2DQ5TfSPUoFDAfVy+VjbqbJofWd2MpnIZHGuIyYSFEyOZto7uIw7CS2f3CzPHC0rOv8ESc9t0KFw3naJgNQjUX/kHheomAHUPPoeYVnq8XknazH6ui+4780KXebG6LCtWNBLx4tGx3dgI4SeUs8J+FT9zSwVTEffonkD9GXQC1UK2nj9tKuir4Y5v9EFlnA==
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bt25-20020a056000081900b0033b792ed609sm9942435wrb.91.2024.02.14.02.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:41:58 -0800 (PST)
Message-ID: <47aeb22c-9450-4501-8bec-e9d69e8f4f08@linaro.org>
Date: Wed, 14 Feb 2024 11:41:57 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: caleb.connolly@linaro.org, lina.iyer@linaro.org, lukasz.luba@arm.com,
 quic_manafm@quicinc.com, quic_priyjain@quicinc.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
 <20231213175818.2826876-2-daniel.lezcano@linaro.org>
 <CAJZ5v0gfz9Lafz20s2AourmKuqQMS9g4heqj=afLbbp_B-2FMA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gfz9Lafz20s2AourmKuqQMS9g4heqj=afLbbp_B-2FMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 12/02/2024 18:30, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 6:58 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>

[ ... ]

> 
> I sent a comment on the first patch in the series and please note that
> 0-day has reported build issues with this one.  I guess it needs to be
> refreshed.
> 
> At the general level, I think that it would be good to add at least
> one user of this framework along with it, as a matter of illustration
> how it is going to (or at least how it is intended to) be used.  For
> example, what is going to happen when user space updates one of the
> limits via sysfs for a given device?

I think Caleb is doing a port of the QMI TMD series he posted to the 
performance QoS.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


