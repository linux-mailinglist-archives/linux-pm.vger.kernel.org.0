Return-Path: <linux-pm+bounces-24078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A2A62362
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 01:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CD619C62D2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C12F50;
	Sat, 15 Mar 2025 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahpWgTdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DC33C9
	for <linux-pm@vger.kernel.org>; Sat, 15 Mar 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999785; cv=none; b=jVTx6TsX9FR9uaOL/mGi+KBZ6hzHSZZ4qdwso08inoxgvZ+NLiS6nsWoOXz/2iBvRIemy04T36DJAa7UcfCWbe4pi5MkT1R4MwEiQYvxixffp/OqucFzLLcPGufGypxX4GymxyV5fo1J3hDFdTxjsMNw8IJFnSVdpYI54c6Accs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999785; c=relaxed/simple;
	bh=EVcLkRoYjzPskNvsgLUC1U6E5af0qrbR6gcf9LQ/UQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leEa/e93gfLAola7FIyMXzGy98XxcvjN3HG8b0dRFljPMBWK18bisXvZfV82SmnhdH+ebvAAvM+P2ndnySbBTIetMjqcDG8kOtWCP5Umh7iwPeM+dbtwhTPcLUEU+qh1TgAGNa+u0i5lqPbQ8/jllSWWSpKgmfYqFomlZeG7UQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahpWgTdZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22398e09e39so57618805ad.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741999782; x=1742604582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1jM8RpZtcKZIilOJqvJ3/LMYhzoydClew6e4ccobUM=;
        b=ahpWgTdZrxepaLdjwWi6FGIjFOmg2quhTaWPIl3GLik9D8p7eQC65Hwif+AMlp1T4H
         hrrQhXL1guNdjxHtbsp7pNBAuOxpQzkHTEyp5oXXeMp6Zdwr5LxHedxoneCBfeD2WFP+
         7W5EIJ/gQzsqwYfUx9528D6z/uZvEPhcXZ2OtaYoI8KTa1XA74QKUpUVQ1XhFDRRKBdY
         vZV+Ux1HrrD0ZIqrsrNtWa4NgujnTfc3r62Ic/lhmrhz+/d71EUZXDwk1sxn24WVdlQq
         moP8q4eIG0kPCrIZeCOLBwz6dAveCcy1/fzznRJFUXZroT03Q2OhQD8w/VsGcb5pdmqc
         GtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741999782; x=1742604582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1jM8RpZtcKZIilOJqvJ3/LMYhzoydClew6e4ccobUM=;
        b=BW76viSy1GJX7HL8JCKsy9oSEzJtqm+2F2w0/Mc64K0Mf3qiCTTkpJOpIFsfOuv555
         Qoj0I5foBAlF1SJ5GN1uiP3ETvFdZDajRJkT1Osbxg2D2gbfJW1y8mm8SVjkoS6+iszj
         RvpoQGX7YiqOGYj2GrJf5dgBVn1DaPzm1jI3getvy4Vct0hXiZB9E9ddukecNfpQEYWj
         KPHRkSERj/fVv4S1Zt1I7/7tHpvYi/3WxJSt+paaEmSQPMF5z4dhO7YCkfvFHL27CUUN
         WAgLHFmmlkpEVyLZCC571wxRl7WV68/FuiFqcKxgEmIOx5cLRYD4uPWA2QMUEhEwk2wM
         dJpg==
X-Forwarded-Encrypted: i=1; AJvYcCWU+ZxXE/9Nv+OAssOdN89BnAM8JQNPjtETicuTICSTAYGn2PVsnbBBQTJfHNUWvgmww9Q3tauKWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvnd1kenD5P/oIHpIk2ZcjhaiBX0iyPfFb/1j/OAP3ONcTKBNL
	xsimzBASaFcHVdzm/OdZ9F/ybuo2lxRu+Ab0WygxGM/0JWxJ0Rxqsw0RahoIYQ==
X-Gm-Gg: ASbGncsIdUZF58Xz7cpTzMkiSEhvb/9eVK0oZgABDmiNGput3Rt/gyBquvfPXoe0sx5
	ECZp85iiNhQMUIGhXiwAJjBT57VR2RSNk4VXeV23uqzmwpGr9mgnId3SndxABeq5vVsEuYiHK5e
	u48bY4MWBnkq2b6d8XCCVj0+ETSfpIM7lhFKPK065QgIIaYNYGvm3g47Nqk3u9p6s6RLJdMoIKL
	4KYvYxSXmErZLKCLQy+a+cvStDWFG/9lVB+F8iE+53PgF3lt8QMAW2QdYD1NgVSbl0vyMDpCOh6
	I2sScPpqJ5C94GRqoO3AeV46iEwa2EQIVMdS4yMgyi5HFpUnBvAHh9tgASsj6M5EB9YXq/IAP7b
	T3i+fTsOPW0CFzS0ypdQEDOmPQCktVGXjjezMveOcLlyovOvjQWwefQ==
X-Google-Smtp-Source: AGHT+IEmHc6dXkowj/KC6TLkI13gyY8Emlnd81lhhSStCWu+Bw/F/Vpl30+Ts5hmEGYnRZqPPjqDcw==
X-Received: by 2002:a05:6a00:3d0c:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-7372234b8f3mr5799632b3a.4.1741999781372;
        Fri, 14 Mar 2025 17:49:41 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:1790:6e62:92ba:cb2b? ([2a00:79e0:2e14:7:1790:6e62:92ba:cb2b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529397sm3501714b3a.22.2025.03.14.17.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 17:49:40 -0700 (PDT)
Message-ID: <914a0df4-96d0-4cd4-ac87-3826fa9c1440@google.com>
Date: Fri, 14 Mar 2025 17:49:38 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for Battery Status & Battery Caps AMS in
 TCPM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250313-determined-wild-seahorse-f7871a@krzk-bin>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250313-determined-wild-seahorse-f7871a@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thanks for the review!

On 3/13/25 1:50 AM, Krzysztof Kozlowski wrote:
> On Wed, Mar 12, 2025 at 04:42:00PM -0700, Amit Sunil Dhamne wrote:
>> Support for Battery Status & Battery Caps messages in response to
>> Get_Battery_Status & Get_Battery_Cap request is required by USB PD devices
>> powered by battery, as per "USB PD R3.1 V1.8 Spec", "6.13 Message
>> Applicability" section. This patchset adds support for these AMSes
>> to achieve greater compliance with the spec.
> Which board uses it? I would be happy to see that connection between
> batteries and USB connector on the schematics of some real device. How
> does it look like?
Any board that uses a USB Type-C connector that supplies power into or 
out of a battery while operating in sink or source mode respectively. 
The VBUS is connected to the (battery + buck boost IC's CHGin/Vin) or a 
companion IFPMIC connected to a battery.  In our board we have USB 
Connector <-> IFPMIC <-> Battery.

Thanks,

Amit

> Best regards,
> Krzysztof
>

