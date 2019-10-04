Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4000DCB3B5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 06:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfJDEWB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 00:22:01 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:14539 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730414AbfJDEWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 00:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570162920; x=1601698920;
  h=mime-version:from:date:message-id:subject:to;
  bh=Zz/4kUum/4LoqYB7Rvny12tH6aVFfBpG02v+rgY5AYc=;
  b=RppXMtiB5i9g1SFZB7rEPCzBZLd3nw8V2shAlP2Zay4FZjA3n0IKiA4t
   MgQXnmpA6VoSC2GXJ4OGxgTAYF85ZZOovqOKgiCeZmqsjwDNjq2H2memK
   gizlYdHDEWdFd2ZfgYP8z3O7C8PXcl/nAOh/KHutg7fhJ2yBMg5r2DOQ5
   dCxnR6cf/txSP6wA4WembKJYIWMIIVud3ipnHbVx5XC5lPZGBwzU7y7Vg
   LU9B7DJM8ZX6wko94YAblG6udxN1Pa5o37fLwrms21NXMQk4doS5XlJPJ
   /bR9I9yUngGRaj3tho/gGm/YgaQxaESS6kvGVgHpmVdcFRG7osIQT9gj8
   A==;
IronPort-SDR: PMNM/tqFE+K1CBs2RfJDc6xjTXMz98uuhQZRkBa/L/e8JcMfcQCTWm5la2Jkv8EQtttmzuHoSJ
 Elw9byBYh3L2sARAnR1O+0D+dFl56I/GdajXOCM7q4ZapvnHbKvy8PzkCQra576dZzT2LDpH/7
 j0lSznaPWkVekxJvX82vOMsJBfO4HbYRELaNVJN34VZMwL73zaIatXUTprUrLgu/W4AHqReSMU
 0px7hvrrTsXC/Eg8GVchhWyjuasuHZYrTGF2hXkxsyyrhUG0kMyeTF4NqxXy0SdvAcbEe1w3xM
 qnc=
IronPort-PHdr: =?us-ascii?q?9a23=3A1Pu7/h/tBw7Ba/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+4cTK2v8tzYMVDF4r011RmVBN6dtqoP0reempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC9bL9uIxm6sAXcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2?=
 =?us-ascii?q?hcUcZLTyFODYOyYYUMAeQcI+hXs5Lwp0cSoRakGQWgGP/jxz1Oi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QMiHtIPsXTUrMjyNKwPUu+1zLPHzTTeZP5R2Tb86YjIfQogof2QQb?=
 =?us-ascii?q?59f9HcyVQzGAPflFmft5HqPy6M2+kLrmOV7PJgWPqxh2I7rwx9uDuiy8c2ho?=
 =?us-ascii?q?XUh48YyErI+CdkzIszONa2UlR0YcS+H5tVryyaMox2Td48TGxwoyY6z6EGuY?=
 =?us-ascii?q?a8fCgX1JQr3x7fZOKDc4iP+h/jUfyeITZ8hH58fLK/iQu+/VGuyuD+S8W4yl?=
 =?us-ascii?q?lKri1CktnDsnACyQbf5dSASvt45kuh2DCP2B7P6uxcP0w4ia7WJ4Qiz7MwjJ?=
 =?us-ascii?q?YfrEXOEy3slEj0kaOabkAk9fKp6+TjbLXmvJicN4pshwD+M6UumtawAeUkPg?=
 =?us-ascii?q?QSUWWW4vm826H5/UHjXrpFk+A2nrHDsJ/GPcQburK5AwhN34Yn6ha/CSqm0d?=
 =?us-ascii?q?sBkXkfKVJIYwyHj4f3NFHUOvz4Dumwg06qkDh1w/DKJLrhAo/CLiuLrLC0Rr?=
 =?us-ascii?q?t34lVAyQM1hepS5plUB7VJdOnpV2fyucbeAxt/NBa7laKvDNR7y5NbQWenHK?=
 =?us-ascii?q?CUKuXRvEWO6+ZpJPODIMcRuTDgO70m6uTogHsRh1AQZ++q0IERZXT+Ge5pZw?=
 =?us-ascii?q?2rYXv9n9FJKGYDuEJqXuzrmUCESBZYfDCvVLh66z0mXsbuJofOQI+8nfS62y?=
 =?us-ascii?q?G0VsldfWdABXiHCjH1fJ/CVvsRPnG8OMhkxw0FR7i8TMcT1Riv/Fvr2bpuL7?=
 =?us-ascii?q?KMoQUFvoil2dRosb6A3Sou/CB5WpzOm1qGSHt5yyZRH2c7?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HfAgDGx5ZdhkenVdFlDoVtM4RMjl6?=
 =?us-ascii?q?FFwGYGAEIAQEBDi8BAYcIIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEICwsIKYV?=
 =?us-ascii?q?AgjopAYNVEXwDDAImAiQSAQUBIgE0gwCCCwWhV4EDPIsmgTKIZgEJDYFIEno?=
 =?us-ascii?q?ojA6CF4Nuc4QogymCWASBNwEBAZUrllIBBgKCERQDjFGIRBuCKpcWLYwSgWy?=
 =?us-ascii?q?ZSg8jgUaBezMaJX8GZ4FPTxAUgWmNcVskkXsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HfAgDGx5ZdhkenVdFlDoVtM4RMjl6FFwGYGAEIAQEBD?=
 =?us-ascii?q?i8BAYcIIzgTAgMJAQEFAQEBAQEFBAEBAhABAQEICwsIKYVAgjopAYNVEXwDD?=
 =?us-ascii?q?AImAiQSAQUBIgE0gwCCCwWhV4EDPIsmgTKIZgEJDYFIEnoojA6CF4Nuc4Qog?=
 =?us-ascii?q?ymCWASBNwEBAZUrllIBBgKCERQDjFGIRBuCKpcWLYwSgWyZSg8jgUaBezMaJ?=
 =?us-ascii?q?X8GZ4FPTxAUgWmNcVskkXsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="80567931"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 21:21:59 -0700
Received: by mail-lf1-f71.google.com with SMTP id m24so564661lfh.22
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2019 21:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=amG90aSOmtrR07i+DuzkZAUHX9myFv9sjojIkK2vdYg=;
        b=f64NNSRJD+jwBQjfcpc9Y87z34oSuv2ACoYNjaM75ZWRh9Eo6N/Wm3JmbwoR9gm/oq
         LbgiXB9DxsGIji05T67aaQldi87Hebx6+ZqFrTrjIUXDRoE3i4NSWhfIcfxQMIHIHUfr
         0dEa8Ol72k1dm1mTI3kXtlfUjOJ1/tpNscdS87k0vG/zkodRLud/enzTI0tvh9LX7p2k
         cmL/l/k3ewBT4tPG++t/u2U68OWfRibO4ZivctLDOcjqfLNDHhwqDNuU+Bkxygyl7eNY
         T39kDlZN4CPBmNU2E7whRa42xxbuHTyuUskNJdfImsn/0NMqVIkKYsoMa8k2e9ny/JNa
         bX7A==
X-Gm-Message-State: APjAAAX45v2D/sm7mF1EWhSKMi5Ot8dTe4jEP5QBQgHS1s0eB+6+sEKk
        l19hu97+URosFhm+GmHpOZOAFU1rZD/BmwsysKSU4LqJwHoX0Ec20MFsYXpQOgKV0WGTRZH6iXR
        Ng41NTnvMbKHiRc6Uykf7cjwDT4jGgiJZ/qNG
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr8095286ljk.92.1570162917779;
        Thu, 03 Oct 2019 21:21:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCGwPRRiYf1Q/eIA5nDBwCgRpd6pymD6rSMeHLbsHofWwEDUxAhe/APLSwXlX8W/Naztv6mOgh6eqkN86P1gI=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr8095273ljk.92.1570162917489;
 Thu, 03 Oct 2019 21:21:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 21:21:44 -0700
Message-ID: <CABvMjLTicqk-ncY18j=UCZhCCugTVkPWKjkWZj9yEccUp3m8XQ@mail.gmail.com>
Subject: Potential uninitialized variables in power: supply: rt5033_battery:
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi:

drivers/power/supply/rt5033_battery.c:

In function rt5033_battery_get_present(), variable "val" could be
uninitialized if regmap_read() returns -EINVAL. However, "val" is
used to decide the return value, which is potentially unsafe.

Also, we cannot simply return -EINVAL in rt5033_battery_get_present()
because it's not an acceptable return value.

Thanks for your time to check this case.

-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
