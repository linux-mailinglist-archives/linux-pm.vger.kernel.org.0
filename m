Return-Path: <linux-pm+bounces-23832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79CA5BE06
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 11:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA3E16F6AF
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853CD2343CF;
	Tue, 11 Mar 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hGLkOhv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1E2206BD
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689484; cv=none; b=AAiNLXU2f9zVQclW+YkpQ6deg+ZAeH9UaCWTiVU0e0Hz6myr8RQP0/LsMeKjBYWJfYLPZBrGM4wXXozJQTIqAVw7+H84IWfKqqvqgklLG5PgIFaO+xa/okNCmOSx1DFLjOVqWga7DI7LtfWc3se8jnWsoIvepI1wa3ojp9pI3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689484; c=relaxed/simple;
	bh=EbXZ3DQ9+b6N6Hl4SN9qCQLNiQGag830oTI8EnFB6Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnqHeS5lLb6EgW2tJBki2bDpYtJWKUO+B6UaSS07fxx82uLelc63wiSmXt0lBHV2OE1lutdI8D+0qulK8I2hTg1lpFDDAbV+51s+ZdMqgCDh85lmZZzkt8YTNnLt6uBYcwxFDEZKfKKQJtYh+PPznmYUhjrE8Iw9kYlR3jFYAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hGLkOhv5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39133f709f5so1998223f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741689481; x=1742294281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=;
        b=hGLkOhv5IYqDFE5iLkNuWygCyyEreuG0TtFOTjd+Bj+I+flIbFqCF4mAVs0Bjf4uXJ
         yW3zq41RXMHvM0fmclIOvzE57JEbgFR7rFSZUj10eY2CKGya97a8eejy3nE1FIVrWgvi
         69Va/2L12qgcEFgn5G7AGxvq3/MfRizQSppX7SBM596yz0SASYC6p32XkO1j+PvRiQ5R
         lcSeTQHtyc8V9a5gkD7817yJVdENTnGs8Pec3L9pfPZOeweq6nAxAHTyg9K+742cvDVJ
         PtjsawwuriCo8IEu7AxsywaTypbChvTVXVyaAfa7vvvvu2hkZ/LVvTp9r3ONhKBasFUu
         eHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689481; x=1742294281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyAWrxEwUsWnM7LVGAbr1T8GXaCm2RFT3dQ++j9eSpM=;
        b=X5Mmp7v7gTitGjlg8BPv/A+/F4jEHTTaYjZ2D5A3PVRIkm2MPaqnxOlU2JUcVeqakT
         WGEzhJm8AFx54ESC9niccoaFo4Af0Onuqe52YIoAhLKEyWa4kLyxg1IkXKv1Tt4vzKkg
         g9RXfw446o/rRwak6CWe1N9A9ZWLF3teMFFtUnL3ESEhqbS7tPu433bS3QJXZLLFY3An
         9hyx0gOKUA5ikPc/3/yFyDF2OzhyP01SZutJAyALoazFd2gU+l75N4kKijaXemNUCR1t
         mosi9gstNmOmVP9cyT8iXqRzc5YPB7LwFMn7tO7L7/iTsRY2HGuXZs5wKe32WcnFFWO5
         vtPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaXjgVV5zwGAQJQ5g6ldz4eeKeHYnlIS6dI7H5/c3cCpbJ+CSm7Du4atmASywdQpKiSRt87x3FAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs0FYVxtMhesHrmlyLXgk7HBhBGciHWFo5ebzea1HDelP6bsl
	GdzqjPboolLYXCiHKxKgU+gXJGIedKdd4n082ZQjAoTvoPE8Id5h+ZWanUGe2IY=
X-Gm-Gg: ASbGncv3zkY5RPo8rEcJa957ddseXE4q7n4kzt7f6MzNsJaw9BY+ZKfe+hlnTwGl5Zr
	zdilv88G6Ry8jmyN7FEiPo3Z85z1kkjCy8hTWKbePkwAaSk7Ak4TsmFqfyr2AqKMf7Z1R7YiXgf
	SdsI0G2J7wI3YFr/eN1OGmvXVEtHEUcEwy43PrLDNFkal8tN5cOwcCcU//nlxEpIMcYnSEwS6iU
	tOsZHcLAvlhZ9ob8CCi+G5bvIq6aT1whG282XzxZLSBgB/XZeElIfuE05tKQsw7BvTReYWuilri
	Um4jKjmiu+dcAmsaRAGT61QnC/fSmlJeb7G+s2Omz5zDqHY=
X-Google-Smtp-Source: AGHT+IF/j8vaXxrz6NQ9qVToImBHcx1sXj5BHKod2F3PwyhmwrRzoNCSAtC5+f+03GzQ5ewdWZTRdg==
X-Received: by 2002:a05:6000:2c5:b0:391:10c5:d1a9 with SMTP id ffacd0b85a97d-39132d82751mr12162685f8f.31.1741689480756;
        Tue, 11 Mar 2025 03:38:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm18059782f8f.53.2025.03.11.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:38:00 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:37:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AShs1dEO0jrgjL@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>

On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> Hello, I've being working on some patches that help to clarify the suspend/resume
> of printk machinery. The last patch on this patchset address one issue regarding
> suspended consoles and blanking.
> 
> This is a part one patchset that I would like to see merged before I send more patches
> that will rework the suspend flag (a global suspend flag istead of per console) and
> the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> register the console instead of using this flag.
> 
> Please review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Looks good to me. I could fix the typos when pushing.

Well, there is one more thing. It seems that the simple graphic logger
was merged for 6.14-rc1. And the console_stop()/console_start() API
is used also in drivers/gpu/drm/clients/drm_log.c.

It is actually the code which motivated this rename, as already
pointed out by John, see
https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/

Well, I am going to update these two locations when pushing this
as well. Let's just get this change done.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

