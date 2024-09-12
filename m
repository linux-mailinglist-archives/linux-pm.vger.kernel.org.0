Return-Path: <linux-pm+bounces-14118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD270977485
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 00:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCAF1C23BF4
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96411C1AC0;
	Thu, 12 Sep 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e81qgHXL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3E2C80;
	Thu, 12 Sep 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181382; cv=none; b=hkybmcTVGk8tUPxJeirzEMVAFIzLi3BnTtYU9A+J5mpMGZPS4CnoSl/9Ct8mwxpqcG4Oc/Qz0kDE5W2RVJlCYQTUjW/asu9vIaSDbgpaVI6X0foibszx9QumyOFg41KWLIlQg+t2fypo4aEsux4TixdQj0HVyZz8/40qoyjennU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181382; c=relaxed/simple;
	bh=D0KsdfpzYaJ+R34imwB84t1tcxTzy7uDwzAnCSdfLl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4RxJv2gox2vVJU3YZD75DEaY19pE3zhtOEimnI6HwrzNWk8XeHPhGRTpbJ7Q4UIYFr5qAXWP/aufrvWt7uMa5VA6rN4V2AkmLc7elwPHzy9s9+XJ23jiLsHE0ozCfH98RPQ9TA3i0sC+3vvHzOUon/IB4calY+HfdFGb4GuzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e81qgHXL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8abac30ddso1259533a91.0;
        Thu, 12 Sep 2024 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726181380; x=1726786180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfz3ffC20am1RxApc5KtkJVNDjR/H4j/9ugKy+x5Bh4=;
        b=e81qgHXLzvrf8cc3D/M2KN86opGJ6a4BVTeCXlajCsY3YLYLbEjVfOmgk0Xcumbvb8
         pkrVdZPYkLoGbuLAExvT6ItuhlCJxeE4vgPQeJKqxY54Mm99dzRHcPY2X+zzyhn5LYTd
         YNgh7s5+UcpiWanjyiiN4QYKW+u7SHEGRErnj/0L11ANp6mp05PRJpyrBGSJlk6LuyYk
         3E1TIaoq2OfqwbUy+b2VtL5WCT7bfpYYgW5iTzjC5UXkmLXnPRL7zTDR0RZxa62Hqfkl
         6gomgiTjivB4Xr4eTiLpmSnwDRdcDiqJ125qzg/b7dyTWhRVoA0u2vzAB5ZkAmka5S+T
         t9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181380; x=1726786180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xfz3ffC20am1RxApc5KtkJVNDjR/H4j/9ugKy+x5Bh4=;
        b=Z9INJ9hGRLhYvzqPxsV0lmAjWpRzOp0v2yrmktOBC1xuSTqnyCISwY1Vk7Xqn9SsL6
         yLxsZ4K7Gor/Tx4djquKEdomwsIZDkiGAHn4YqciNyU2fk+5bajVpsACHcNJ9LDXS+l9
         HUcoJyIYN3F3niSLEP5mQxV3hRNJmGlTLmz4RIWf6mf2uU3tACGc8vajWPvv7+LY64u0
         QPa4o5rrsc/DPl5QRQhdqLcTqlchRQr0qVJPZLlsr+6zjggJ7a0ekcfz0PUO5aWpeqj7
         dbiZIdMrm7xAgnDpKcGVe+H/O047jxg9sr8LjVUl/ahsKbqSgY5WotZInG0ErAJQq5PI
         vNEg==
X-Forwarded-Encrypted: i=1; AJvYcCUtNz5WZ1qfwLSyBtMtvTl2Pu2Vm6Slw7H+/jGf8IgavRJXxStY1JCRaNWYLsAao+8dyUc/9NVvnYM=@vger.kernel.org, AJvYcCWw9Vss70utWStmWVOiLm3Obm3V3UvpwiFBM5tzpM1YgSEPUv8KAmwCp21q8l24SFRod+lCKJPu7lssiEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmhCWK374P5DEzYTtjI29q7ILw1xlPgCSigm/X6F62MGZEfk/
	IFGr97Lttb++roClx5APgyykNzGmDxv1O1HHIm2+kQBip75p8/2Q
X-Google-Smtp-Source: AGHT+IFNWm4n0MIsKKq0PGarqFsLiSTjHXWHrXbLKn5gk/7hkmSpIOlZufnM2C64D6bd8kekC8datQ==
X-Received: by 2002:a17:90a:c28c:b0:2d8:7a54:51a6 with SMTP id 98e67ed59e1d1-2dba007dfc2mr5249627a91.33.1726181380491;
        Thu, 12 Sep 2024 15:49:40 -0700 (PDT)
Received: from localhost.localdomain (111-240-84-197.dynamic-ip.hinet.net. [111.240.84.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ced092sm246449a91.38.2024.09.12.15.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:49:40 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: jwyatt@redhat.com
Cc: jkacur@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	minhuadotchen@gmail.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	trenn@suse.com
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
Date: Fri, 13 Sep 2024 06:49:15 +0800
Message-ID: <20240912224916.79367-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZuMmqAmr62ErjqHc@rhfedora>
References: <ZuMmqAmr62ErjqHc@rhfedora>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

>On Thu, Sep 12, 2024 at 10:31:19AM -0600, Shuah Khan wrote:
>> On 9/12/24 06:50, Min-Hua Chen wrote:
>> > This RFC patch is actually bug report. All *.i file will be
>> > removed by 'make mrproper', including raw_pylibcpupower.i, added
>> > by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")
>> > 
>> > We can reproduce the error by performing the following command:
>> > cd linux-next
>> > make mrproper
>> > cd tools/power/cpupower/bindings/python
>> > make
>> > 
>> > We will get an error message:
>> > make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
>> > 
>> > Renaming the raw_pylibcpupower.i is just a workaround to fix the
>> > issue above.
>> 
>> I need a non-rfc patch for this. Please send a proper patch
>> I can pull in once John has a chance to review this.
>
>I have reviewed and tested and this. I am good with it being a stopgap.
>
>Please send the non-rfc patch.
>
>Thank you for reporting and sending a patch for this Min-Hua.
>
>Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
>Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
>Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
>Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

Thank you for reviewing this patch, I will submit a non-rfc patch later.

cheers,
Min-Hua

