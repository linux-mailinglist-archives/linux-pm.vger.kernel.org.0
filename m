Return-Path: <linux-pm+bounces-33569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C42B5B3E815
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9061A86705
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3591EDA0E;
	Mon,  1 Sep 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOHqtVu2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF59136672;
	Mon,  1 Sep 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738847; cv=none; b=Zat6z+LMDEhf0+reXY5fn9m8Akv1p4MfzsLamGbFFlu7Bj8sksFSZtaOkv6ENh9rceUUNMsH+y8yxLrnPXftj7+M1jF4rfHg3gfcoqNCJtqnmduCb9eMjHzDovkAXHN0WBW+CHeteqEbVr7H7JiiRXRjAFktMB4Lvg+BRuI/yCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738847; c=relaxed/simple;
	bh=F5K3rbEz6hJHw7YJ4IpVd10CtWqVoaUEdEu4A7Xycds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFTrvaKhZPD7dhFbcqJdmii45s5wCorLlD5ynU+UOP51h9LM/gDGZNUXOA8LnE9dQu+5I5Xmcs5z1INvP8x+pi2/oupUNIfscLYTq5E7QQfTW6PD+DeIWL06u5ZRN7xWvW7eGrN7G6M0g/4Ua/NeX1w93hlMVi9vdH/V1hORxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOHqtVu2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772627dd50aso663580b3a.1;
        Mon, 01 Sep 2025 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756738845; x=1757343645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ4WcZ7eOxBtKFx4ULGvvK6qM1Bsr/rRsHz5qzwJR6I=;
        b=YOHqtVu2/S2E36wocwqNSLCwAAIv9j7JaWmE2bdjneM/BzesUSYX2PaJVzkkRbTI7G
         HGsyt2LudB+xPSCF21Ujv4z7XSRVG/i1yx58bzDwRbBqCYIu5T3rDYt98FXODEXHH1O4
         64Cn9t42mTLewGzqPQmPxfoSvmy+euNcZUBzXl19LlpLfNjiQuj04rddl7xereDHFYE9
         c052gRMCMB/gb7E9rc2IvkwQIb4nCd9D0Bz+B5qor5MBUYTA+TyTUWyJWZ6iNOcOglmi
         djQfmVhuTFwW+hzasAl9PyvH5mkcjZENwWo6vg7YOHqq0J0t08vuKitbJ8HX/Re2qnBf
         aYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756738845; x=1757343645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ4WcZ7eOxBtKFx4ULGvvK6qM1Bsr/rRsHz5qzwJR6I=;
        b=drA+9rXolewVzkFbQZ4+Az0gixvY2IISRDKEAXMIbfO5zsTh2RgBlFiuzzrCJc+pTp
         6Zv5fnN3LH6qLSmxOlNZU3+Q2ZflkoqsTMEr7ZLQT4UzzoItOxoozmVd8amBKXvLTAbz
         KOKB6B2sPLzdEbpHuiA18ApmanCJC9VwWj2MujN1XQ7cliXQCoBlAP8hTYjb0xkbpfRC
         cBXCLTpm/zD6/4V/J1DOP1aRVQd9+YSb3GCA6Omig6ARLGRGIy0wOAdP8E7g973/PW9R
         H9HXQzbNoCNKjYoCDpU1eDyrX/vSYntgs4XIk7ng0zc0ZIk+vQO4jAK0K9dT27H2HM9e
         DJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyDO1SNIW1r6nIs1YkR5T6FkAMEUJPyHxvoF/sfnSkFpealmnXSZUvktdevq6mW63NMJkQfz0FKbqMdE=@vger.kernel.org, AJvYcCW1nDv3UB0szbeKgE1FjKhXD/EtB/reSZy6KqtWmmobZQmV3jfcXSC/y2u04Y3mt3Gc1XnsFFPMiaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYxoLEweQf5zx8w4uyLmm4TI9+h03o9qBVyh+uWBQwx5/8AGA
	eUTozfwqGUPey4O27xx+oacPcZFnQjgHssugD2MYmb6OKnMmuB6BYnSa
X-Gm-Gg: ASbGncuFS5Sq5niFEdzucegIGWoCtnEbmSpYo0uFZQzTV4eC9d9wmS7tYl3f8pAM1KZ
	JfgQspyOEzuxu+OcsfmmUi70c8t9RvvbaS6y7eq8c6rGFM26D760bvoFRVzvMhkPJAK6LLSw58Z
	TzhxLlvmwWMk+U2pzb2+PD3lq/SvkCxlnXIf7qRiXKweZxFBjzLkYBdkn/zUiKv0UAuQbt4xDqv
	CDhE2ChdBL38szYWdBv7DikJad0xFKJZJ/FVrT2zdrtnr1TMYViI2HZ5RCZXSm/Q/oj9PlF+MEo
	4Q291v8y8+Ydpd6wX2cEocnn4wr/4UFk9FCxkmJULXVJgziyvJkXi3+PXuxYI9LSw9ET/TI49yZ
	al4mcbj+kH+H/MqrfuGjGuxIzbWViXH87lNS9hPfS88wldMHzYHS0Zg7El/2NCJZH9tu+ktk=
X-Google-Smtp-Source: AGHT+IHSOg6ABAG/AxG8rrQTksVV0NWpwd523gnHpf1IFLyVCZdVy9xfEvfabJwEUah5KqR1OCv6xQ==
X-Received: by 2002:a05:6a20:42a3:b0:243:a9b6:de9c with SMTP id adf61e73a8af0-243d6f3b987mr10834591637.24.1756738844931;
        Mon, 01 Sep 2025 08:00:44 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a3e3sm11065659b3a.13.2025.09.01.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:00:44 -0700 (PDT)
Date: Mon, 1 Sep 2025 23:00:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, jacob.jun.pan@linux.intel.com,
	jserv@ccns.ncku.edu.tw, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmon: Fix undefined behavior in left shift
Message-ID: <aLW1GEpKXVLo1Oue@visitorckw-System-Product-Name>
References: <20250901144756.1179834-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901144756.1179834-1-visitorckw@gmail.com>

On Mon, Sep 01, 2025 at 10:47:56PM +0800, Kuan-Wei Chiu wrote:
> Using 1 << j when j reaches 31 triggers undefined behavior because
> the constant 1 is of type int, and shifting it left by 31 exceeds
> the range of signed int. UBSAN reports:
> 
> tmon.c:174:54: runtime error: left shift of 1 by 31 places cannot be represented in type 'int'
> 

I forgot to mention in the commit message that the UBSAN report was
triggered when running sudo ./tmon -l. Let me know if you'd like me
to include that detail, and I can update and resend as v2.

Regards,
Kuan-Wei

