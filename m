Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4410053BF41
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiFBUDC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jun 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiFBUCm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 16:02:42 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 13:02:31 PDT
Received: from smtp687out9.mel.oss-core.net (smtp687out9.mel.oss-core.net [210.50.216.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60E6F1013
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 13:02:30 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2AQcwDRFZli/7NplnpaGQEBAQEBAQ0eCwYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQECAQEBAQEBAQEBAQEBCwkJgUYCgToCAQEBAaQ9hxkbgiWJYwsBAQEhM?=
 =?us-ascii?q?AQBAYR4AQFZBYRzJjcGDgECBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBgSBH?=
 =?us-ascii?q?IUvRoZUIAcBgVYBDgEehXUBAaxugTMNdIRZFIIQBAqCc4E7AgEBAQEBAYlBh?=
 =?us-ascii?q?V99gRCBWII4AYV9g0CCLgSSRoQjBBs7AyEVGDQSgSFFLAEIBgYHCgUyBgIMG?=
 =?us-ascii?q?BQEAhMSUx0CEgwKHA5UGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMuAgMYCQcKA?=
 =?us-ascii?q?x0ICgoSEhAUAgQGDR4LCAMZHy0JAgQOA0MICwoDEQQDExgLFggQBAYDCS8NK?=
 =?us-ascii?q?AsDFA8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQjHQMDBSYDAgIbBwICAwIGF?=
 =?us-ascii?q?wYCAnEKKA0IBAgEDBAdJRMFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIA?=
 =?us-ascii?q?ggnGwcWNhkBBQ5PBgsJIRwJIBEFBhYDI3MFSA8pNTkGfA+uUpBAnjMKg04FK?=
 =?us-ascii?q?QeBCQeeSTGDYwGXEhEBJ4FXi1SWaKgSgRiBf3AVggiBHFAonRCBEAIGCwEBA?=
 =?us-ascii?q?wmPCgEB?=
IronPort-Data: A9a23:5pi5oKNep8l5bBTvrR0rlcFynXyQoLVcMsEvi/4bfWQNrUp3hWQHz
 GVMDGGDOPreMGv9fI91O4+0oUMP6sDTmoVlTXM5pCpnJ55ogZScWYjBRqvT04J+CuWZESqLO
 u1HMoGowPjZyhYwnz/1WlTbhSAUOZqgG/ytUYYoBggrHVU+EHl500o58wIEqtcAbeaRUlvlV
 eza+6UzCHf9s9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAO2e00uMX4qDfrZw00U7WVjNrXSq
 +7rlNlV945ClvsnIovNfr3TKiXmTlNOVOSDoiI+ZkSsvvRNjio4wIxjG6ogUkJGrguToYh22
 udsr4PlHG/FPoWU8AgceyZ5NWRcYoJo1JXuBiXmk6R/zWWfKSGqmqg2ShhuYMtBpbcf7WJmr
 JT0LBgMaB6Er+e/xr6qDOJrg6zPKeG7ZttC5C48lVk1C94pGcDkeb/v1+V5zQxhuINEXvnUP
 +YwPG8HgBPoJkcn1k0sIJY/mvq4w2H6WyNXpUjTpqct5WXXigtr39DQ3MH9I4bQAJwIxgPB/
 j+DpjuoRAoGPZqAwyCC+36mj+nD2yX2RMQbCdVU68JXvbFa/URLYDV+aLdxiaDRZpKWMz6HF
 3Epxw==
IronPort-HdrOrdr: A9a23:0JgpT6+r4d6jj5J4gUluk+C7I+orL9Y04lQ7vn2ZLiY7TiX4ra
 yTdZsgtCMc5Ax7ZJhfo7C90cC7KBvhHPhOj7X5Vo3JYOCJggaVEL0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,272,1647262800"; 
   d="scan'208";a="82056740"
Received: from 122-150-105-179.sta.wbroadband.net.au (HELO WIN-J7GFDBAO51J) ([122.150.105.179])
  by smtp687.mel.oss-core.net with ESMTP; 03 Jun 2022 06:01:24 +1000
From:   "Martin Otamori" <info@mandy.com>
Subject: Acknowledge this message
To:     <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <okkmart68@gmail.com>
Date:   Thu, 2 Jun 2022 13:01:21 -0700
Message-Id: <202202061301207EDDC436AD-2DF4A6CFE6@mandy.com>
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_LOW,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?122.150.105.179>]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [210.50.216.236 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [122.150.105.179 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [okkmart68[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I will give you more details as soon as you acknowledge this message.
Thank you.
Martin Otamori.

