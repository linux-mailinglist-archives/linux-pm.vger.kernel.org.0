Return-Path: <linux-pm+bounces-41190-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G3zKL70b2m+UQAAu9opvQ
	(envelope-from <linux-pm+bounces-41190-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:33:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC2A4C549
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 284D14CE433
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F742847F;
	Tue, 20 Jan 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilTP+W8u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BD421EF4
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938996; cv=none; b=bSxwf4mJoKA+GihzewYsxXQRzCWgiEU5rblQmz7B18a2I8V1eDtbJUPVO4IsX7vpVPxqWS9SpIFQy2uVqFh7DzMD1klJvW5rA2ZgLO0EA+4F5NhGMU5Hk2nigNxbnLPeAceSA4t5JYQjztFcI6rqIeATICOSUhDdY3jVSzmAV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938996; c=relaxed/simple;
	bh=dpRYr3skIgV0rzJn+6D/Wwyl8T3WJJeqflIDq7vz970=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNQvLhNHQDw9tp4hWYBmrmytqJGECmqu5BLMSPnsx2ieKuPwVXszYvDY3msOLTxaMHl+Dgjxlqx/tRax1nSco/oqnguw8uPYCabZh0PKiKgqv+4aT3lXDDq0xmKggP6ljkaDGE38Gxrb9DKgCLMq1bPY2pkZI4p4raknlQL8yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilTP+W8u; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12336c0a8b6so12128329c88.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938993; x=1769543793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPDgUMFRl+w+AbB4KcmndfGR0As68bgylKNbbH3AGMk=;
        b=ilTP+W8u0C7h7XBeoah7AsJ9JL095ZDFwxa6je9YceSe5kL434AEa3e23rZIbJCd2e
         jnO4xLKmsw5RyE29tSBo1CYXW/XhUGjPEV8BMF3noJo9ZL8fHVkWA5vnGSaSQLiOet2G
         u33Z96XEok44vp/L8jcalhxIbLF2VdgdGVnEmHJyBf+WvA6eY40iDArMrDCHTCvuYbGV
         R2IRMW4ie8d0lDUcYo3zWHSLjXKq85+4R/INtdkQm9SrWFC2O2lwXCSL+pV6WY7K/Y4J
         v/prpxeGXBy2mhWGLzQMm/WfVUt37+/etLvLAhGEDEyKKhHhl6i31LdTJJSmRTJrCn8K
         b7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938993; x=1769543793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPDgUMFRl+w+AbB4KcmndfGR0As68bgylKNbbH3AGMk=;
        b=i0X6DvqdbSVBA2oMD72BNWzwsgc9k6juTg2x4ET7YHLqlDfpwm0NPjsa78FGY5B61V
         SqNuef/ULjl3gPuwARov9QJ8zHQTNSqI+ZlksE5WykwFJRnXc+JnrXqeg3FpWu+QP0tV
         2/Es6cSeWwD2D63RiCU5MbrA0+t+hFdruQVO1GSn3QaU+myqRh0WMcjrpLCt4RCGOgnJ
         rNW7Lg8AfzOWNZvC1ZVWu6gjwDVlBhy3RdUdVEySZem3FWKyIPWpjT8YfYVMU9Ldt8oX
         3nwUF0AUAi1j6/WABIkaSu1LEt1D30BoYUVWFDOgdBrmTrbD5qRDEIdz8bjDjTxuUGCZ
         LRrA==
X-Forwarded-Encrypted: i=1; AJvYcCX3mFRZJnQxy1R9ouTpfYAv1SUU8Ct6lRF9Ge0tEy6hu3e+rtNKAE/QL/AthSIZv2WqZGzetwudeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIB+XlNJT6mpGBfHA4A47KgkIjg2Qi+u8Xn2Kf7k1yAna47wNu
	QwxDtvECNU4I+78BWqiY25GAYXnWAVmgoNdiuuN8OOImN75isMojTESI
X-Gm-Gg: AY/fxX6IedXyb9LcgIRjJBSmu/gjtSWtXq10zBgcy2jkxWDjWtEeY5XaiN6jIOr7V6/
	pap9oNVV9gC7UKlJW9LoVmoi0U7sUYnVETqs4ibVTIACk+RCb19kf7Jr9v3G/v/VDnqQujyM371
	VSkCelbBTzwJTXznJOqweHi6TRSkPqerSGeGHd0qvzTYzHwhdn9oYT/y9ya9y7aOufiEGSfZAU0
	N20a+BopkqJqp73z75uDUcW/3te9NQxdiAPXbLDljjCFzRteT3f5az69vSFxkXH/Gz+kGFplaun
	XKhO32uxBCKH2Wur88gjR7+ne8HrAOaIsE4Tn8R1Qn1CYipmL3+TprTw0YVkyqz276alN5B4BYN
	XKrbINhjBawOC1CdClIZ4nrJY5rODcQ0l83ok4teNOw0xuYIAlBP1OvZAdRHk8ZwA0g89USg2Da
	bcrVLEt8SFS01MEBLnKmE+kQzeqMgPyqQvN1dkrvd8n2854K/XX9Ho
X-Received: by 2002:a05:7022:608b:b0:11e:3e9:3e8a with SMTP id a92af1059eb24-1244a7910d8mr14869120c88.49.1768938993269;
        Tue, 20 Jan 2026 11:56:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm23388705c88.8.2026.01.20.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:56:32 -0800 (PST)
Date: Tue, 20 Jan 2026 11:56:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <nab4yksjgk7jbofm5fkrafuz5c3dmi2oocdzgoscfj6ua7zwfh@olnrxt7sa3qp>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-4-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-4-visitorckw@gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41190-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de,linuxfoundation.org,ccns.ncku.edu.tw,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,linux-pm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4DC2A4C549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 13, 2026 at 09:25:59AM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Events Keypad binding to DT schema format.
> Move the file to the input directory to match the subsystem.
> Update the example node name to 'keypad' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Applied, thank you.

-- 
Dmitry

