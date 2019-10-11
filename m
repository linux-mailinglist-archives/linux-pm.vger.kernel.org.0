Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB42D46DB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfJKRp7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 11 Oct 2019 13:45:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:13342 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfJKRp7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 13:45:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 10:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="207473920"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2019 10:45:58 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 11 Oct 2019 10:45:58 -0700
Received: from crsmsx104.amr.corp.intel.com ([169.254.6.181]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.18]) with mapi id 14.03.0439.000;
 Fri, 11 Oct 2019 11:45:56 -0600
From:   "Hernandez Lopez, Fabiola" <fabiola.hernandez.lopez@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Frequency not returning to fixed value after AVX workload
Thread-Topic: Frequency not returning to fixed value after AVX workload
Thread-Index: AdWAW7g0RYwhbvwkQrq2viRm3SLyeQ==
Date:   Fri, 11 Oct 2019 17:45:55 +0000
Message-ID: <67737C20FC7E4D44B44817ABFA5B1DCE6EC01C77@CRSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDM5YWE4MmEtYWExMC00YTYxLWIyZGEtNDAzZWNiZDhiMDc1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOGs2Z1c3XC9USWR2VVwvbm8yY3dsWCtRc05ZUWdBRG9kajM0YTJ5RzBnaURKUTJpczYxMksxUGQwRGZDTmR6ZytEIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, 

We are seeing an unexpected behavior after applying AVX workloads. 
After setting the CPU frequency to a fixed value with CPU Freq - userspace governor and applying heavy AVX workloads, the CPU frequency is decreased (as expected) but it never returns to the previously established value. This does not happen on all cores, only on a single core. The only way to return to the desired frequency is by setting it through the command line again. 

We are wondering how can this change in frequency happen.

Thanks,

Fabiola
