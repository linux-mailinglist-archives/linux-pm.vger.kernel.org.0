Return-Path: <linux-pm+bounces-16865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4249B8D92
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 10:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D70F1F233A6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D4195811;
	Fri,  1 Nov 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWUjr/Y0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5A18A93E
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452690; cv=none; b=OTmBTHpEhpQz+8PHcs6ixkZxoguL+KH6lone3HKxI+LrEC+2Xbe+5KptJJtFl1Q0+7N1MsL8e67nQ13Z5k/79HGa7hWMRbsFOk1dqZehfTXhgPqYJ2RFp8PEWe1p65v+IXRVYyD/VdvhF9kNiyNfKpuj7SdcLv3NP9CdiFBOBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452690; c=relaxed/simple;
	bh=iGBOTIP0XsSA6R7T39YCzcqONCZ51vSzVDVaWop1K/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j5Anj88S/zLU9KYszDa60lGY8IzsylHsq3r7XBDeSAKvcOFJXaPtxyOeRnkwa9b3apiV9X+IeBcWQgBhrgy4ke+r+wUL8IF6wBcbm6+8/sRdnm6g7c1nvZuEiJs6FxAAt4BAn+Xqjx72R9ZnJa3dq57PWx0fiX+l7VIReNKfiH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWUjr/Y0; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a46d36c044so966931137.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730452687; x=1731057487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t1KkDbfeRb8/B89WlBjrN65+9n5V//dcukh2+tciQ0U=;
        b=QWUjr/Y0xMRoZVT1z8r0513aOYrYgJ7HCDEWGOYy9E6iGsIZMKJfU3pFSR1OuPgXXS
         nB0pDcdMBmKxMvhcGdbsV34c0bsUptBBdK1jZNF/d/v0zw8k12X26MxdXckTJKe9hEi2
         DBua/ZncL88V/WSVTCC1nYooIc94gZ8kvlGzX/mlC6fpcz6D7pt6H3lztC3sGTc1I1me
         zEya2yVCP0lWWusK69awb4KOLbAGXACXz9F9rmqdudjq+buMh7qjUvaEBOR0Pxq0sife
         iTtPmJ3UsZPedebS3V4Xmz3Ju6TE/D9zF54/P7uGuMFRrmNfVFFKJs6LToMtK8rNVeBv
         HIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730452687; x=1731057487;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1KkDbfeRb8/B89WlBjrN65+9n5V//dcukh2+tciQ0U=;
        b=G1hmUEuuy1jHyDbSZQkCyWVgr75GUEkOC2SM4SDNSyEUB/LAz6m2qDYoTBsWBE+8hw
         7NWJF/AlMqIiItBkzo5w2xJ9MaX+k7zDgFRk6FUjBsLTVzeB8lJHRIOx6VXTzvYzZq4e
         sXv9cZygdmyvqp/dZg2TsBATlWL2nZw8F/fqjHzJOKRUHjS9Ag2yHb7kH/BFJtl9zHJP
         j/w/4BTK48QL94I06fYRViFL/BU3rbH08bpifLRSxPbqzAFKTF65eBrNnUDcSMmnpHFY
         Kd19tW6OLRE4C//7XnAYBdTpUhUHj4ecXDZbyhDbHmbSB5YhLm6r5HWCEFMFJJIOt+R2
         TO7w==
X-Forwarded-Encrypted: i=1; AJvYcCX02M1zPq10rbIhHe2RGUdncaBGnJvOuUtL/ityTgb/dMRypKCw/xN8f9q9dbBehkLREZP2aM1cow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMCkJLfqWfjQU7Meyp6expJsRprQiyXnyBeBNnTv8HO2DR1LW
	r9cW8RWmdfr6OI/gIAcg3Us+kLB5fDS08Q7XEDU83iLPKtMtr48tH3J6oVzo+QCjIUneXrZ+Bqy
	GrPg+ydFOjPR7WvhCwYX0d3fx7YTdaoBiogvXUQ==
X-Google-Smtp-Source: AGHT+IF/7VeE0qypAZsvB0GHvJRs7OROyaNMivE3QaLLNk11pGcfGJx4Il504Fo5uGv0ogFJJ2/UpZC3ZSupAKDX6qc=
X-Received: by 2002:a05:6102:d8e:b0:4a4:4868:cfd9 with SMTP id
 ada2fe7eead31-4a956c98c4bmr4297604137.1.1730452687441; Fri, 01 Nov 2024
 02:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 1 Nov 2024 14:47:56 +0530
Message-ID: <CA+G9fYtioQ22nVr9m22+qyMqUNRsGdA=cFw_j1OUv=x8Pcs-bw@mail.gmail.com>
Subject: next-20241031: drivers/pmdomain/ti/ti_sci_pm_domains.c:134:26: error:
 called object type 'void *' is not a function or function pointer
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux PM <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, d-gole@ti.com, 
	zhangzekun11@huawei.com, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

 The arm clang-19-keystone_defconfig builds failed with clang-19 and
gcc-13 on the
Linux next-20241031 tag.

First seen on Linux next-20241031 tag.
  Good: next-20241030
  Bad:  next-20241031

arm:
  build:
  * gcc-13-keystone_defconfig
  * clang-19-keystone_defconfig
  * clang-nightly-keystone_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/pmdomain/ti/ti_sci_pm_domains.c:134:26: error: called object
type 'void *' is not a function or function pointer
  134 |         ret = pm_generic_suspend(dev);
      |               ~~~~~~~~~~~~~~~~~~^
1 error generated.
make[6]: *** [scripts/Makefile.build:229:
drivers/pmdomain/ti/ti_sci_pm_domains.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241101/testrun/25629126/suite/build/test/clang-19-keystone_defconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241101/testrun/25629126/suite/build/test/clang-19-keystone_defconfig/history/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2oElzrg2GdPSWnESXlKVCgvhX5u/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2oElzrg2GdPSWnESXlKVCgvhX5u/build.log

Steps to reproduce:
------------
- # tuxmake --runtime podman --target-arch arm --toolchain clang-19
--kconfig keystone_defconfig LLVM=1 LLVM_IAS=1

metadata:
----
  git describe: next-20241101
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git sha: c88416ba074a8913cf6d61b789dd834bbca6681c
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oElzrg2GdPSWnESXlKVCgvhX5u/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oElzrg2GdPSWnESXlKVCgvhX5u/
  toolchain: clang-19 (19.1.3) and gcc-13
  config: defconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org

