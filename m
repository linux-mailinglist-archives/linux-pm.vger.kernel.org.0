Return-Path: <linux-pm+bounces-37563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B8C3D524
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 21:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F301890873
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76833CEAE;
	Thu,  6 Nov 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfkbZs6T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8823346AB
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459445; cv=none; b=IKTWsWBmsdaBJme8mxT9p6Ct0l8hUo3VmVRn+nHsf+4CWicQlnFi4g2bFjpEppQZp3PWkZfZ9o9uYodTp/mBbECA4CZurDEmA/IN4H6WrIvU4NXfEFc2GBY8KRrtsnzkNssaRdD3eXMKOaajpzg/WVF5RkuId7BLiq+I+IULVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459445; c=relaxed/simple;
	bh=cHynKQOLc5ii50Gt3yz1TrQddPsrH9nDQ8nW8Q6lgRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpwR/zrL02R1xe+l7jkLv0/hFYDIoIX3i1Uxf56MTG3jvbXLfNMjqrWd6QK8xHE7kYfy6HPNgu0m0YaZqA6zpYGNLsKon4Xj724z70+encP3m8Mbiwo3GM4stcD71jFxY+8xPIHuBZNYUMC397iM6XQzfbe+gwmNTDIzBd81eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfkbZs6T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so4045f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459442; x=1763064242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7yR2bHRK9gzns7PW7bXBGW/+15SiHKbafHBuxGBdc4=;
        b=PfkbZs6TFtpzKRJ9CoYDZOhw7NtdtNTuDF40poqZ4LB0HZqYFeA17JPa1cCpLgWYF2
         f5mpQxbsJlIomF2p4NHppD83ogUPEc+lia08KjnpJ65y3ewpv3uPgjv1VUhfUsWIfsDn
         mzswVHeHgHo2yVJ+zQAVHxlIDaMGymBv/2kAYVMjrxfdujzczVPChBu8XSE41X+EOJXa
         XmwIEvYw3u8051s3H2BnN8NZNI3eaDFHNehR3YSoviz7FbCnH/yNcMBg/G1YBS9xWp9W
         zT0e/4DbOK4cWFOVxIa6qOzJwrl6KXu81XNc0leke/C7jhPqLDuhQSeNgDTZgv5gLgFm
         f2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459442; x=1763064242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7yR2bHRK9gzns7PW7bXBGW/+15SiHKbafHBuxGBdc4=;
        b=M82Olo74SjGzLJlsgdxhKaHFYkWa68jQR9voXC0X4ANxHcGLGllrvspRsWlyWTnH3m
         oqT+b3eGrDxGTXk1jfFmiOmrDVVu6rA2BD8TasnJaVYnCrY5NXa2PuJcnzYqVxSIH1Nj
         6oNEYiPd7pRdYQ37fQyv7cPlzgzWQQCb1WblPM2OtXTA2jDobdk+pa0IENaYEJ1Ed76L
         jwu8seL1Dy/hAZ7163QrwRJuYTbVwcXD+Bgly9woohAIefnVkLlW29ZpjeIbfvROiWWJ
         Q1I29N8XVTIwIrCbPAgbKLNJqjZl9JvECZa/Z0zCzm3v8ThJ8m7yTzdy/ejIgiaPiNdm
         Rdag==
X-Forwarded-Encrypted: i=1; AJvYcCUzZfV/gQ521ZNR5rbcOcmJe5IFPESP/+glQrjCsKETuU4zBGuzd0l2fl9DWI0KuD71V/XP4lKNWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbgb2FUt/d88BGI0TKaALr4R7XsyOQ/tsxJXOpmq5FSArCO0B
	DKlcjxUhRZKuGvy2Ok4PCzuZBDewD0+QRWw9IXNh2f4Vd58xF+Hu9pEE
X-Gm-Gg: ASbGncstRyxTQa0aTDP9Fa3ZzQ8Hvl6ywWgyVmwJkyqKemsHzu0ClUvDR0vLzGiMd02
	1/xrD+7v76pOZ65l181Ft8KEEud3bysAukTTk8Px4jd5FtDOV8fgXEz5LXNTsDvU4fsMxgQBrzT
	gWpPPRmVFdIpcc6idGogUeKoa8Y6Jo3Rv5BxzbZJOkTrugs/NBl0U5z3kHBwjTUaOyDgTe9ABjr
	VRIWr9yIl3pnP8zaZpPcA89YhkWmmjQ2PQrYji7srDaTG2PBgZviKwljqEo4DlSIGln02eKRLr4
	MfsJD7cf6bORDZ0kY8hYsHCRLWi4MtHXgYifu3KBu37zGchokfmJCW1Hbl/wBlK/2q7gIEN2o/b
	L/HZxmDXFdcVWOeo91aIexibS3ajU4sfJL078hc6/8eXAcjBOu3B68XrVSA5ohxmUGshE0aOy
X-Google-Smtp-Source: AGHT+IG30M3iSEO8D3c9yVbtgdXYbEKgf+NVCjIV8t9OJJNcKVz7gcFg2k8DBnqnw/S4QNyvM11IDw==
X-Received: by 2002:a5d:5f51:0:b0:429:8b01:c08d with SMTP id ffacd0b85a97d-42ae5ac38eamr463450f8f.41.1762459441776;
        Thu, 06 Nov 2025 12:04:01 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42abe64fd90sm924084f8f.21.2025.11.06.12.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:04:00 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: superm1@kernel.org
Cc: lenb@kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pavel@kernel.org,
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [PATCH 0/3] Fixups for hibernate issues reported by Askar Safin
Date: Thu,  6 Nov 2025 23:03:56 +0300
Message-ID: <20251106200356.8213-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106045158.3198061-1-superm1@kernel.org>
References: <20251106045158.3198061-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Mario Limonciello (AMD)" <superm1@kernel.org>:
> Askar Safin reported some usability issues with hibernate messageing in
> some failure cases.  This series fixes those issues as well as some style
> issues I noticed while touching the function.

I tested in Qemu. Now everything works. Thank you!

Tested-By: <safinaskar@gmail.com>

-- 
Askar Safin

