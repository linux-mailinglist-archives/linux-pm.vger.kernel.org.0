Return-Path: <linux-pm+bounces-28966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5794BADEDCC
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F2618882D9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37E2E974C;
	Wed, 18 Jun 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3Rd4B5a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB52E974A
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253289; cv=none; b=YnHO5+zdQjoK3/vDIG9ocnJYzzymsjpWIrxlSPURCfDlWD+1kcD6mA5z5IqZ9uMVCEhf5AQm3HkzD48sNjn+r3dPxXuSr+0B861XKJa6IAze4K3KjNz0syNar80xF/7hxe5FvC/n3i30LHNNNJeFbz9lCTBEG0Ul8LGcRHMZUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253289; c=relaxed/simple;
	bh=CQWYf5240z2KPgUiqlRF9wP/4RTd2ZVb2iMhFh38Ahk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjIqBGZoWhs3ilS58mYec83h3ytj053hUR/usHqOo65lg2dAMXtgcrUjQPrrH9Eki/pW5Wc+sJXsk2OA+ME4+mEFKpDeAWNBlEnfQfqUYdjRL7H/93DSCAzzVntaTpPZNFYA9mgeeurZtWfAulR8/rEsj9NzFD7gXDwU4BqHTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3Rd4B5a; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453398e90e9so39710005e9.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 06:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750253285; x=1750858085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQWYf5240z2KPgUiqlRF9wP/4RTd2ZVb2iMhFh38Ahk=;
        b=K3Rd4B5a0O/vYISxLM3S9R0Lns2i/o83cAKPOZuPiBUQ2y8rBvSPlBN+7nPsjrSxlF
         dUAh7PZVyztBqzet+0LqZR/dXIv6KeNd6P5WpHZ2Dz0vrHBd3ydL2B0dESJrpmeyzxJY
         FbRMWjwzkrHyA/N0nZ4PTppUq+Jd+GyS+gicWIr6rziApzgq4sHZbCZKvhbRWfddbYzO
         IhuF5XeT2MWJMpyhts4KLO0QdzmMl7MSWPwM1qmMiXKowD0TItqiQfCSW2mlnKTlBqNR
         TavoQF2ArdABrMzWumXNu9up5Za3M6MRPeoQQ43rWX40hkIGzkicO8F42oT6HKZQUTrn
         NU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253285; x=1750858085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQWYf5240z2KPgUiqlRF9wP/4RTd2ZVb2iMhFh38Ahk=;
        b=lii4ZXaFYklX028AFuOJzJ741hHIc60+7VSpeMWX2Al2EUHFadOH6bEGSmG7ZsSVFo
         Yrs+gR5GhsY/+l529lOvU2P6cuaNe0m8tb0kfV+taw2WdqfhGfKE8/75v4qnqo0q8khz
         xIupNxM16gONjEinmc5Zv/tKTmQO6k+7YHFEZ3zIrm8USeB7zVgB5u29rQPp8JBFd5HE
         0rnwNt88s2DoT/AHrrxhKZhvQhvS7b/65Ho7F3PyVdFz4VjNR71jeTxDsSWOj0AOTC0K
         G7tTrxEeecQCmsh+GrDaKTR/1cjIFRGUIs6MpOK61XWH5DlzFKAhlNbo3HXWd5IImods
         nwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOxaO8O2CJUye6EqGehcny8JpYMM1ojUSKKygwGpb3LE8B2DhGiYCA64fv+2ONv118vdMgFkh6BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+FD0gQ0btnVuW/jsOy95sg21S5mQ2TGqNu+ZWYJIXoRThPly
	b8jCCpOQ8BbrL2jqrp/c/W0inYSjBDjcoM/XeXr2gFx6qo7ELptjulU0Hd+mDpFgtqU=
X-Gm-Gg: ASbGnctrP1rC8kgrLmYuiwRaOlPt9ec2biQbrAnztZLAPW8ol8E5TAcM8/25Z08/+dd
	HFyi6uThD1qOGzf3MZ2vih7MPs6W49Tr+PHfwr/4iLfLwtdois1KQlSqRhGgAehGO4jxYZ0ZxpS
	3LNjayfyTcj/EHzHNQRsQITYNHhDWUf63T9MRJFUL+NF4nuEcJYr3kjT6JyALafbX0TrtZeKaf1
	PzOsR4q9Tly990UHbEjJvjYSRQBofZA8aw/6Fe3b/KdGIwXinFUR93ykUn8fNqTyaRkzfONcsCE
	95Xp/ZMEkKmhWTj7uT/i8cdOL/6DqkZePOIYiBYXS/ZbsCzKyeekxatcyVc/HRv8ZbhYWfJjwQB
	6RtVNHShm8wdqLKiPI2ZHnpjsuIgmRY5xNAFzrQ==
X-Google-Smtp-Source: AGHT+IHsYnHdB0JOFwGUBbfz/Nz+oX7/Nt70Eian/OZWF7OabodaY5ap19RQq+MRP53eF3NO5RcWyg==
X-Received: by 2002:a05:600c:1c28:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-4533cb4bc8fmr134287185e9.22.1750253285546;
        Wed, 18 Jun 2025 06:28:05 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm16799417f8f.26.2025.06.18.06.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 06:28:05 -0700 (PDT)
Message-ID: <ca3c6d72-2fc0-4e04-ac61-486ad75257b8@linaro.org>
Date: Wed, 18 Jun 2025 14:28:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock'
 is held
To: Johan Hovold <johan@kernel.org>, Bryan O'Donoghue <bod.linux@nxsw.ie>,
 Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <TIkPOGVjPeCjPzjVtlSb6V5CIcpaXf2-6WG6HjAyaOW59Hj01-9VK7Z8DKadakOKr6fJeQICi6h0Z8mft9DQyg==@protonmail.internalid>
 <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com>
 <ca9f7308-4b92-4d23-bfe7-f8d18d20de10@linaro.org>
 <75a46897-040f-4608-88f5-22c99c8bed97@gmail.com>
 <04ab699e-b344-4ba1-9ca1-04b6e50beefe@nxsw.ie>
 <aFK2Kl2I46dTYBI1@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <aFK2Kl2I46dTYBI1@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/06/2025 13:50, Johan Hovold wrote:
>> I think we should sort that out, either by removing one of the locks or
>> by at the very least documenting beside the mutex declarations which
>> locks protect what.
> Feel free to discuss that with Rob who added the icc_lock_bw, but it's
> unrelated to the regression at hand (and should not block fixing it).

True.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

