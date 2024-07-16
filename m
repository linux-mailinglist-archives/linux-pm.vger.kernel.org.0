Return-Path: <linux-pm+bounces-11142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4593245B
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 12:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC321F23F52
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2024 10:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7300D198E79;
	Tue, 16 Jul 2024 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M22kyT+h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5FC198E6E
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126949; cv=none; b=BmilvfVx5whxdbZHH41NfGUBfn5sP954xwA/XuH1jKXD30vjuN+JHb2925fdtdy+PJN+fba1EXH8tMrpqZo/kKmPlVoZMTQSlDARg8tTpo/Y3vwTT9sP0R2FDfZAtCV437Z6eoog3Bhcgg6PKEJpOXLaEf9GY8KHOxSPQ1yGyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126949; c=relaxed/simple;
	bh=6PplKpjlGffvC5RHfmAoC1yuM9SJwAHrJsEqjUdSKDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD6B1vsnPT3HF94xtaQXBLH/j+YCh4x9zoLJhtDZzZuWI4VTc0pxB8GEhJ7B+1JzhIBzfWDkqDBPl9q4aAE/RZFHI1FBBkbTRTkggPLAhZeKc1Hj3FWbX7fHbVk3iahH7eFO7I1bu/DXQW24u8zSO+6zBfVLGia4k5UuYjrKGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M22kyT+h; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5957040e32aso3507677a12.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721126946; x=1721731746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JSSdPTO8wok657BaYCcgzt7XSIZBPPA7Zl3G6wPHAJ0=;
        b=M22kyT+hlxc/bvxRjJoaKlIPOoUDohKKLjaVr49DEGuai8a4jpRNRj71Y+Mp8ujIAN
         N9EAoo9XamZwcV/fJBOUz6nz6j/Lc+qZgTNAbdvZfNRQ2g7ELFhGQ5sgDWI1S7lv8uIo
         OfdY75+hzbVywWb3xO4vnYQ+qqtJ4GJqiB4BjKz6pYifDAVBfhYT5GiRxQsY46w5Zljv
         bxVwiviwHsvmwut2s1AedJfpXBzK/Cd2y1l68my5tO2d1/8c8xB5V/VyzeJl0vDG88is
         sVRw4w92tKeqUacMxXOI+3uT+aV5RJWuLqfFovjIDWKDeLDov8FEudXJmZXEjqOuM6de
         N1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721126946; x=1721731746;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSSdPTO8wok657BaYCcgzt7XSIZBPPA7Zl3G6wPHAJ0=;
        b=A88Xc1raE2t+exXX2BEh/p2iyQF+zi66ggufuTwAFSRWW+umT4aAtZdh0ERT/FFg4n
         cS9l7aiqQnihwQvCl/RwCkrDUY/JO0ke5vkeFkzPt0lr/F+OfZdr1F3y/pP83b+btGmj
         GoKx6wa35QqNB13AJPP7TusvPvNV9lxwnDHPYPhJfYGxk1M3VT+csyYSyABrSmqW1XZn
         OfAL6993MJpgyg97xvcq5ujf7PS+zUCNqeGFzDxuMxl3Eob0vIopmxklOjYQRqtgZI4k
         kyxOKicb76bUjF2gxh2z0wTHtiArzsCs4jb2ZxKmgCj2+M/rlDv+W1Ux8tdCYRg088SJ
         w+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW9bOEml3iNmt38jDYa6Spd/hL3aXlslha7AhNpGqhTRy85v7fKmbT0KVmUoZAeSm713rXBWWnkL3gvEXLrwhKdijmbF/oAFns=
X-Gm-Message-State: AOJu0YySJfkGN471hqAR5Z6+VS6DmmDwccRzsgEmVVGnRomUfi7yGahF
	I+888ONHLYdeArmf37+ONKUDkWKTKrlBHFprGCUl7wcWXYN186q1h2yRM5A/+BA=
X-Google-Smtp-Source: AGHT+IEsrbkhN72GyfBmxo/hV8M5Q2LQBsNbIHXZvi0vkLi4V9jtbDdrRXWd2qscg7UBR3yi6L6y4Q==
X-Received: by 2002:a05:6402:26c1:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-59eefa9bf9fmr1444655a12.26.1721126945732;
        Tue, 16 Jul 2024 03:49:05 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b2504b915sm4744682a12.34.2024.07.16.03.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 03:49:05 -0700 (PDT)
Message-ID: <2ab03911-1774-422e-b04d-f67fc75ec6da@linaro.org>
Date: Tue, 16 Jul 2024 12:49:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] media: venus: pm_helpers: Only set rate of the
 core clock in core_clks_enable
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Marijn Suijten <marijn.suijten@somainline.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-1-3dac84b88c4b@linaro.org>
 <0a9d7f9f-871c-80ea-e5b1-c7dee354a175@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <0a9d7f9f-871c-80ea-e5b1-c7dee354a175@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.07.2024 8:07 AM, Dikshita Agarwal wrote:
> Hi All,
> 
> Please ignore this patch, didn't realize it was in my workspace when I sent
> the other series. Sorry for spam.

Hm?

Konrad

