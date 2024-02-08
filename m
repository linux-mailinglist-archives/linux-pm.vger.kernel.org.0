Return-Path: <linux-pm+bounces-3668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7DB84EBC4
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 23:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121BD283C3C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C564F8BE;
	Thu,  8 Feb 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFobCDkz"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E84F888
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432031; cv=none; b=rOM9UAke1zU+YfTI+gWardk6DTstFVAt1/ybtT3wi7R815FjufiAgfBOIL1pbGkUesvYSxsyS9a9XLCrBFp1U6Y+7eI3wZSc5ljnAV/bXXtde7F0dRsK+oUEPdQIAaTvTLBbiJIZh6wB8Lt+uJs98d+RplYtKosrGdB+NEVmeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432031; c=relaxed/simple;
	bh=WgiBKEizJ1Nr9/P0edOywoED0tE3kc/R7lk7Gr4hXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVX6mYTi/V3l81t5UaUugBQpzJYXprZZ1CDdN5GS3m+0/OMsocHJWtV55JGvcF/cqVhkOLdzn/QgvKOdIMoTI+SWIm7LiKS2eycrYy3M7Rp8kqG1FKRaIj4XK4sB7dN5lDfz2l88jgT8sVKMWnWNhB/3JoJm3Ytz98UZM+z5ow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFobCDkz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707432028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ycEPqZLGpnCnzCxSi4khqVSrV3LcSojgaxf6ZNumZw=;
	b=fFobCDkzBcTmHR8tKXAvBB8amtlbZz9DxjH/doW2e6wMmp5+y4hoTbsiS2EuFrXQa2+Y8v
	+5kaBRppYxSPY6YX4EBElMOo7noBOsBrajSxZkX7FFjbGQn6oEz2Jj+YYO1mY7eHpbvyvo
	VyahQsITsLHPpmSJTZj0AfDUZS3r6yQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-4HvL_cEDMQqqqiHrvVLahQ-1; Thu, 08 Feb 2024 17:40:27 -0500
X-MC-Unique: 4HvL_cEDMQqqqiHrvVLahQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68cb759751aso4173776d6.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2024 14:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432027; x=1708036827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ycEPqZLGpnCnzCxSi4khqVSrV3LcSojgaxf6ZNumZw=;
        b=eg2EerOzhfSMBarNdRkqUyjQhZ5/d/mbyzLkK/7gW4Ivr4yoQZ1sutG0Yf02DRDdPa
         oJJ6ftF/bbCOtOFrN24axpHw8fBietOZ5CIc3Gw1+g3yj9oYWmAgfNMUdLlUTIvGZCX9
         9qKmwgJxR+opOEcqTnidTSVtkXrK7xRcvwT2KQsQiionv13Ws6pKby+2Jcc8nB2xTopA
         AQwWMDCcS9LyDHPkOcIc3mamQXnboZ65zohP8lqnRYm4kT+3PnvIpXrJAS6ZInxuTX87
         63p9Bo7XqLog00uLmUZBKSyTWNyH02T09fcGjtJwcCYLQ8Kbemb5T687aolPjhrUauHh
         iOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXHCvMGFAmZxR/YPj0ndQAWHh8TaOuwq1AqWMD8B0z78CxrmP2urPXK9nAICBd2kWrIgblIJ97Ey5Cfm6KmfXhDlWURKxK4jrg=
X-Gm-Message-State: AOJu0YwIO+x1dME4yCditk0cbvJ2UnBYxGhFDvWGRrKMzoBldijBx+lY
	f6Mv87ljEFkpC7udbbLKvUoR1X9+CNtrzr66mPRRTowIpZRpXBsouQSyQH0OY4tzSZ4De59Oc1v
	WcqgAWF3pVwZ3sN32o2Lhndxmp0awLpOKN50MVtWEEkLGJx4CPLzT11bZ
X-Received: by 2002:a0c:9d4d:0:b0:68c:5d4d:d823 with SMTP id n13-20020a0c9d4d000000b0068c5d4dd823mr641118qvf.17.1707432027184;
        Thu, 08 Feb 2024 14:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVY9IMW/luM8KccH5a1J718sjNe4/VebAq7wJPEa3L5YO/q6oi3fkBE6P6MyZ/xcQrXdWztA==
X-Received: by 2002:a0c:9d4d:0:b0:68c:5d4d:d823 with SMTP id n13-20020a0c9d4d000000b0068c5d4dd823mr641106qvf.17.1707432026955;
        Thu, 08 Feb 2024 14:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcKABkyvg/1h3Ln4j2HcqyFpJCJb0KMDbQu/7iAEzOv6TR/hAltgVR9+04P75FiGBPNQ1uqOqHsoC5dLmP0z5QPbp0XKO+6UehmiGqkPu76K2xWEbOJuS2IF3YQs24EGfSIKqcOBthXTms0UQtUybxl9kYUyDJ1Y0lZmrc66R72o+JH589LgofwkVEQimbYfTMGd29KPSbfKEtxyPnSV+qnulT+tIh2sfTl5AK2QzX/X+4
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id ly10-20020a0562145c0a00b0068cc62f3409sm220698qvb.23.2024.02.08.14.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:40:26 -0800 (PST)
Date: Thu, 8 Feb 2024 16:40:24 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] interconnect: qcom: constify things
Message-ID: <fikip5ecdzcsud6jh5rk2kvp372atme4kz47jj47eopzasg73u@ziqlnp7zupu2>
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>

On Thu, Feb 08, 2024 at 11:50:50AM +0100, Krzysztof Kozlowski wrote:
> Still some things were left non-const.

These changes all look good to me.

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> 
> Krzysztof Kozlowski (6):
>   interconnect: qcom: msm8909: constify pointer to qcom_icc_node
>   interconnect: qcom: sa8775p: constify pointer to qcom_icc_node
>   interconnect: qcom: sm8250: constify pointer to qcom_icc_node
>   interconnect: qcom: sm6115: constify pointer to qcom_icc_node
>   interconnect: qcom: sa8775p: constify pointer to qcom_icc_bcm
>   interconnect: qcom: x1e80100: constify pointer to qcom_icc_bcm
> 
>  drivers/interconnect/qcom/msm8909.c  |  6 +--
>  drivers/interconnect/qcom/sa8775p.c  | 56 ++++++++++++++--------------
>  drivers/interconnect/qcom/sm6115.c   | 12 +++---
>  drivers/interconnect/qcom/sm8250.c   |  2 +-
>  drivers/interconnect/qcom/x1e80100.c | 12 +++---
>  5 files changed, 44 insertions(+), 44 deletions(-)
> 
> -- 
> 2.34.1
> 
> 


