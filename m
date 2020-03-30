Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43631198787
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 00:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3WlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 18:41:15 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44303 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3WlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 18:41:15 -0400
Received: by mail-pl1-f169.google.com with SMTP id h11so7325277plr.11
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mxmSVLbbAMQ2+epTj8jVyb9QQMFn1u2oWAL07Tvr7gI=;
        b=OGZzTQ0+j6uSOaUMXwnzjoknjRSRo94misVaY373xl2fCm8szr6lkxLk2F6Y23fMR3
         x/BD+ws3Jxu4I981csU+vi7TXsbfPXPmpJi22PNRmkg/KtJS1SlamA7TLw/zLFXp5DiW
         Pcc7yI8zsINhXHQzF/Z554z44zb6ot6bUd+f8fzo3dzcPEobri1Of0XB3+bIDWol7Rny
         fhDIobJUgI7Uq6tjLXEICeYbHSbJvkw4+kecioCV+XSGpyPGUhpJstc6xRfRqcbGv/GM
         HhcW/MqjMAd+bAhdwk1AIl4QO0TmvyRIW4PoUPpxjEimG7uRoBFbhf/GADzr6nSrofna
         RjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mxmSVLbbAMQ2+epTj8jVyb9QQMFn1u2oWAL07Tvr7gI=;
        b=OMEFjWVBkEAUYdGrM+I6L9u860IggiXCxyUd4cs1Q95oyV8xQX1y5YgV3z8MgJchRd
         brhE3AAKDEfAfaUIlF68QC95kF/cyrGMZfOQqsFny7PdJpExz5OjMADnANcukIC3R1GM
         Fz4SIFmf/HhwVPqTp4k33drDCFzqdunoT2D+PjUSwARqGMvCGK7gWWj3Rx4KeSxT9sLR
         RrrxIIE6Sy3waM78E3D2+PfGlw9nz0uR9m4MMgSdLqY/3lG6F2CQqzThlUqEYyFVq3L9
         tFoov3EzeYUIJagDWOCsmbDw1gM6KG82jKCk3VzEVQnMTJmTviXA9ViqyrVBaMxs/JEt
         IO+g==
X-Gm-Message-State: ANhLgQ1j3i4bn0fGO4bK4YeAD6UcHVjjxpyS8NuBB98AFZUWrzWzlosE
        A1O0KGCCkpAzyzUlXpoyj+YjXf2AMsw=
X-Google-Smtp-Source: ADFU+vtgXeLOMYtaosSrgeQ5rahaMRa6E3imeiNyTpCuXEtcQJyY+Br7eJeNxuf0XPud0CwHaXONPg==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr14712702plo.156.1585608074248;
        Mon, 30 Mar 2020 15:41:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r186sm11131950pfc.181.2020.03.30.15.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:41:13 -0700 (PDT)
Message-ID: <5e827589.1c69fb81.cc4bb.27a4@mx.google.com>
Date:   Mon, 30 Mar 2020 15:41:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.6-141-g61fafa3ac67b
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed,
 6 passed (v5.6-141-g61fafa3ac67b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed (v5.6-141-g61fafa3ac67b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
6-141-g61fafa3ac67b/

Tree: pm
Branch: testing
Git Describe: v5.6-141-g61fafa3ac67b
Git Commit: 61fafa3ac67beab5d2e0bf439da2523bd035cb0e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

---
For more info write to <info@kernelci.org>
