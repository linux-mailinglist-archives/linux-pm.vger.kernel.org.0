Return-Path: <linux-pm+bounces-26556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03758AA6C5C
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DC23BABB4
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA09268C75;
	Fri,  2 May 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyowpTXs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C601D267B84
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173647; cv=none; b=tmUzanjqd514FI6XWw+7dOxKJEg42j2hOs1ESO1NoSCwo2Ad47T28+A8SjA5CXU6nFIYJEiouMPZUMNoC6PBcsuFLKKRqwKP4pupJJK0QUByr0XiUXsg0CnJu9QdXQvVy56wcW51ufI/ilrRi5oevuoh+rrGBVPsmNKtiRzvbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173647; c=relaxed/simple;
	bh=Jn4eWjXxwsoqBV85M6GsL2+wR4fJEbwSADRw9jJ+1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlqIPYnA1OES3EWd8KBSzfTLmX9GnrgI7Elt9Ftxem1Jo33uTjLGgZt4LhZ0xMhJpOhdVcMe74itbz4Od2EJC5mV/UBqIl35eGOmAINU0YjxUF77ADBju8YGV4q9DFlUClxaw2RZjm/E9E6czlTpQaLLGVWeeA1dbTiAxcbNQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyowpTXs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33677183so19660535ad.2
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746173645; x=1746778445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9CBhyGDLFpnb+f5rsG3NlbjD1cjKYpOIM2q4JdOS8g=;
        b=cyowpTXsjL2zxgXj1XI9wFYIcQbYM50MxhVTzyX8NC0B+biSwUCQoEw/2/7PU7gmmT
         ulfpw+sw3Ksga/mX6qR488sb9jAWWjSjzsCR/HhV7RJZrDceLrm70nGFXJcqu1+aqc4N
         EyzE8iETxmM+ltSUuE1Z1IVFyUdO9Vb33q5S08qujdsISd+SCvKoh17ShR+vLDM8FB2a
         J85AdBGX3BQ62EKhn0g+NKVAAenOd9JKh/FwaSm61XGWX6ZsKZExqaxa7RufTWop1iHA
         ltXBlO38NIPjT3/X3nvWtwHbsBc39MzxfZTEquBG+HLixgGqRtNonldsuXPWi+wDx6Jk
         Ne/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746173645; x=1746778445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9CBhyGDLFpnb+f5rsG3NlbjD1cjKYpOIM2q4JdOS8g=;
        b=ssZMTTYWVG2lTs0DF+U4UtlNlIyWAioXtUCmjFrmXsU5HI8l7nx5LKrTsq4GQvrayF
         I61Ou2BJZcFBdshCvMrj9wd+r0JynXdENvG23OK9oo5TNSbQ5LNB94AgEVHXOusHXWWC
         G5J2T+Ubpqe7fBRFTwqs9JB+2uVRCpyHtvfke3wIIL84nHuZpF66kCsQkbDGk3wsdP0f
         5tXADDAriTWGj78PpJ7hEPlWucnr3BJ8l+pM5aoPdPISPf8bamIRR/vuZQpGBhSLNMqS
         DUqkfsRk9FgnR1eTLvILKWC2HqOOa5xzm4zYawyI/kRIg1PwvmDRg9IRUVkEL6iosPF6
         cmoA==
X-Forwarded-Encrypted: i=1; AJvYcCXUXL6BXloOXztQvM9HzNiZPB8TBRcMQjmexN5WN4luqSsbt2YzyNPdY2WmYQRhXM55tb8okqLlVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUt72fpjaNmHfBKd8K/bluo3UkcPVS8+5490eOF0zqE1i9U9v
	/VO2S1HvuzVTX2rXiktdTtz7OMfwaW0G1VXThmPX4y6+rW3Jhbn95iVnQx94QaY=
X-Gm-Gg: ASbGncvNE5p/D2XcbQL5ygyOxZZIYpbQhi6LYCTQwdu/a4F54lBPfbk9LwjiblXNqTH
	k44hEPCeEpkvPJWoELeR8ZEojgPUbq/ixutnKANN0uaOjvLLusM7bxzquBT5tra6K/+2rNKCA6f
	t/tSqhKsFlmDfgRVzYuPfI0/mTtkTv1YddktEj+hPMS8w2C7jRMdkTtfN6MfxV0fySYhIAW79YN
	srhQdvwN1tKX9sZaQOC0/LXjUWYYDMm2SPeiJV0vnz9ZaAXsBWaQbUef4DlX3UxBUfAinLIFSZ0
	mh3Ci/ZeoHqSLzwnlu/Vwa9BH4LlNNl5azGERbCvZr7/CkkHw/Ay
X-Google-Smtp-Source: AGHT+IE8k2uHCd5vOWDOxwC36pkdJWkb0CZOrK041eLixQ2GEf6iz7bejpQdIdbRQPU3r3GiD0ut2w==
X-Received: by 2002:a17:903:3bc7:b0:223:f9a4:3fa8 with SMTP id d9443c01a7336-22e103571b1mr31592105ad.19.1746173645117;
        Fri, 02 May 2025 01:14:05 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15232224sm1644065ad.253.2025.05.02.01.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 01:14:04 -0700 (PDT)
Date: Fri, 2 May 2025 13:44:02 +0530
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
Message-ID: <20250502081402.yjagnnjrfva7u4cb@vireshk-i7>
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-2-quic_ptalari@quicinc.com>
 <20250502053758.utawzhq6famwenc2@vireshk-i7>
 <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba02745-378b-4264-883a-b99764701d0b@quicinc.com>

On 02-05-25, 13:31, Praveen Talari wrote:
> Shall i keep commit as you suggested with your SIB.

I already applied it to my tree. You can drop it from your series now.

-- 
viresh

