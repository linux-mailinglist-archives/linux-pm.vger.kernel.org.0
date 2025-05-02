Return-Path: <linux-pm+bounces-26551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F3CAA6BF3
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD867AB8E2
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AA26D4D3;
	Fri,  2 May 2025 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuARuY7Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD30267733
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171934; cv=none; b=NfmkEkePA51x0OIor757bvJwUG8cX9GwCnxeujtlneop8qu8d+fw0tWb8WIOKgOkatTevJG5h7qk5ThiiiUl7fMBXAZKSi/btBPguKeAC9XSHmrtXuSPDKvQvmDuSdG90Yfhz+i2TnSJ/ZMVLuBzDRC/XwjmR1cguX5CBtJEs5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171934; c=relaxed/simple;
	bh=9m/cTKzQOx6GhsUmIqqJjYJwWyeHCRKXqXqMupFRk6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWY/aDb71KgWCDSfUpE0JhnhhhBedDD9i/r+ADo5gItpZIgNn9JLWNqzRbbbRxJ2usQvwf15cFoaCykEmDXQmfUuG/3DDYFgQy5uQPAgsAFuIZHfMHDWQulMM+ENf75EAiEOt9FnPg8gZzCCE7BL+faf2eZ8KLzQhjaXEvZ6N3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuARuY7Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b828de00so17705205ad.1
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746171932; x=1746776732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=foBGkx3MDCARyYK8aHOja5EZFd7xCOQNBSYVh7guhVU=;
        b=QuARuY7QYb9JQ73nyuLdhYJpDI9l/QQF8NYwpWL97ipkrDK34ewqf8aJ/wNbjxNVi0
         MEbczXfIEGSb0F8/gcI4Fd7lg3iWXvQaGgD8TaNcVkDNJbqhpoMe7/JT+MHWv0S2qDL3
         AbI13O+CT3k+3HSUEribm0nXVTAOB//iJjOxZx9l5FYaVSCpLy32pZ7M8bsy1mj1hao/
         f6xGZtC3MfHXtiLqpOp9BWn3Z9Tfw5xKsQFzyVA1krVPOiNsQ6fYWWViAXAi+hl0sFho
         xZAZgsEnfuIe2YTNhxploR6+n2YrVO8y/0BUAzHhCdNMUBTDS6n67M3SEFORMSiwUfhC
         xvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171932; x=1746776732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foBGkx3MDCARyYK8aHOja5EZFd7xCOQNBSYVh7guhVU=;
        b=a/RxdQ/ksPK905a8jT9JMAsBeHzpbxNtLtxxmoA6pdnkqiExEPBxig8pQtS8kBN+dz
         5LSiy/pArCY7zXwGKbPk1uWlqFk8ZM0ZJROtPIIf2BGcoMGn9EeubnEJjlQb+0OccSmQ
         6pwkvEi3eZph4kWTOUIuoEzofEcyLLpNMUquDX3oxRPkvBXF8GqJICsgy6IOBVapuqGn
         htReYdR2rSglmvZMXS0jA49JzwE8v+d3s4bFaw02j6+qBlKG1RdUdMeQOWEsKlC8+o9B
         GDnU+AA8q0lajt1r3RKwtQYYPACJUNxRITEDQ7QXMnbPgPVZwz8kAOkiOwUkOVjPYizZ
         dfWg==
X-Forwarded-Encrypted: i=1; AJvYcCWbD+Bw/DR3iEnBPm+BWP6oSdLSVSHGv4taptUJEG84FCVc2M41PjmEXrEbnyr+7KrnipY+iD4nlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHziiRQAx0iWpqEuEpp3LEYKEZqpMbNfj2rdWOp+/hRAGV78e
	XFoHY4k+XqIyc5LlxNyxzMZ3WJiOc+DMg4E0Gu2BCUoTCaqYDbX6v+rt1zTjFx0=
X-Gm-Gg: ASbGncvSWsND9RAM0HIecQA2js2DU11iSfxiGOy3pWQCy5tsnIpP4hO8SuPvxz59v8/
	0Y+HME8otLFMRZNY3Ram+lJmdyhWYOpVwBXYYIxx0xEfhk4OHMTLJv+TOn9g7Kne9cDRB9MwTXx
	jCC6uoQFd+DSmb91M3BjM+fGNfQ9rH08653uALQn5wk2Ra5EqjfxswyQd2j7LO6Z4eyhCpZmCIy
	tfy2B1SyGw0RIHVaaiBM1Uchb7GijTeb9I7SHVOSKKslAmnq3DXheANJfoYyxej6m1sjfYTa142
	kLZXY4o09HsVkXJ1B2qW7kEBvN0KScfoRr54QFNc5Q==
X-Google-Smtp-Source: AGHT+IHiu8yTtPFT2bhfKp4aemqoUhED3Q4p8zfzNdCBrWjmcCkccsiiaVDUk2133S11VdBC/UNYjA==
X-Received: by 2002:a17:902:f645:b0:22d:e57a:279b with SMTP id d9443c01a7336-22e102ea0cbmr38882945ad.24.1746171931711;
        Fri, 02 May 2025 00:45:31 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb08sm1236375ad.128.2025.05.02.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:45:31 -0700 (PDT)
Date: Fri, 2 May 2025 13:15:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com
Subject: Re: [PATCH v3 1/9] opp: add new helper API dev_pm_opp_set_level()
Message-ID: <20250502074529.ri73hs6xyztn4k4y@vireshk-i7>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
 <20250502053758.utawzhq6famwenc2@vireshk-i7>
 <e72aeda8-035d-4144-a9ce-ae276bca87bf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e72aeda8-035d-4144-a9ce-ae276bca87bf@quicinc.com>

On 02-05-25, 13:07, Praveen Talari wrote:
> How come? i have synced  linux-next today itself and pushed from it, even i
> didn't face any issue.

Yeah, you won't face any issues, but scope-based cleanup helpers were
added recently and should have been used here, though it wasn't
obvious, so its fine.

> Let me know how/where rebased i.e linux-next or linux?

linux-next should be fine normally.

-- 
viresh

