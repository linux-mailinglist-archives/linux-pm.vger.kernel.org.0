Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0809F86EC5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 02:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404329AbfHIAVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 20:21:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44675 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732796AbfHIAVw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 20:21:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so75799596otl.11;
        Thu, 08 Aug 2019 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qJ18L1wbrERX6F3k10BGEMdcTJ2aPiTL4BfastDFNCk=;
        b=efR77BEuls51ClSBywaN/hcJ6AZ5kn0vIw/M0u8cgAabCxj3RPufdHV5E1zFLIPjh5
         VLQe4lQ4mfafTAjeFWtrG/iApUet5NUBLELLd8cIU05T/6SJU+oQSWuZxnsck5H9e4+d
         AVqYTen2tOawpHvT88kTFJ+rkFlUjutbPiH2qtNIfZXKzKb2j42mkPjoj2qoSlCjWzBa
         03hQyHaULEXxY81DUZa6zdt1ZD9tYWybRTFng5/Vb13BSD5AZ7lVsIzyPuFFga6wyWNe
         SK0zzHsRmbI+0uFe0MrUwL2xkALc+H6kLZFpFlq/a29ZzgjfRfLpiUXDJBDErrGk/KJS
         vDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qJ18L1wbrERX6F3k10BGEMdcTJ2aPiTL4BfastDFNCk=;
        b=JdGVI2THjL+GdCadLm7SoJu/YjaIbm0B4SUY0uJZtlDS1O+oOXBiO8AQX2x8glpLyX
         rm9hwEN290nHVYf7m98Pxq4nizUiKR689A0O8aKxVKpMrjE7Jemjg6zkDomuDxsAQyMV
         8QDwZoQSSBQ8VQbC1AZhxHtp2GoGoizB2uZ6QWKvdcaUEDBm7J47ARmMCGm4VHAzxMTm
         1MA+oVAoujYia3lD1o8uEnLkgmOM1JDCRDAfRBdcro6PkEPLs57WbqjQpXNr0E6hfv1l
         El2F+UsdPiyTOehV0IISL5tUPdjBdi5146AyFKitdnfeaGWrOZjgXVRQCPYDpMhl1cfs
         7a8Q==
X-Gm-Message-State: APjAAAXh7bxNVjlV0bW3xer9iYGZDIjllMhRpcv9LhC6wYT0nFbTAzra
        /gZu+M6sY1faffNl2yW/YsE=
X-Google-Smtp-Source: APXvYqz+CkU4806/CIx6WZm+rcWifVImcUB5taTQGzvDeO2HlNEropKLCzMbdOV3P7x3CatDHMWbTA==
X-Received: by 2002:a5d:8451:: with SMTP id w17mr18797106ior.226.1565310111075;
        Thu, 08 Aug 2019 17:21:51 -0700 (PDT)
Received: from wandering.us.cray.com (msp-nat.cray.com. [136.162.2.1])
        by smtp.gmail.com with ESMTPSA id l7sm8426377iof.81.2019.08.08.17.21.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 17:21:50 -0700 (PDT)
From:   Shaun Tancheff <shaun@tancheff.com>
X-Google-Original-From: Shaun Tancheff <stancheff@cray.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Shaun Tancheff <stancheff@cray.com>, linux-kbuild@vger.kernel.org,
        Joe Lawrence <joe.lawrence@redhat.com>,
        "'James E . J . Bottomley'" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "'Martin K . Petersen'" <martin.petersen@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 0/1] kbuild: Support building a tree of modules with -M=<root>
Date:   Thu,  8 Aug 2019 19:21:03 -0500
Message-Id: <20190809002104.18599-1-stancheff@cray.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently when building lustre against 5.3 kernel modules fail to
generate <module>.ko files.

Lustre builds a tree of modules however the numerous modules.order files
are created but only the modules.order file at the root appears to be 
read.

This changes the the scheme for KBUILD_EXTMOD to write to and read from
a single modules.order file at the root.

Shaun Tancheff (1):
  kbuild: recursive build of external kernel modules

 Makefile               | 1 +
 scripts/Makefile.build | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.20.1

