Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53457CB2C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiGUNDI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 09:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiGUNCz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 09:02:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9687AB27
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 06:02:26 -0700 (PDT)
Received: from c100.localnet ([87.123.244.21]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5FxN-1nXRMK3GeD-011EZC; Thu, 21 Jul 2022 15:02:17 +0200
From:   Thomas Renninger <mail@renninger.de>
To:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc:     skhan@linuxfoundation.org
Subject: Re: [PATCH 0/2] Introduce powercap userspace frontend
Date:   Thu, 21 Jul 2022 15:02:17 +0200
Message-ID: <2083447.lt9WnQXQnj@c100>
In-Reply-To: <62c11a15028d27d3c4f50c2d34f47be02b15c965.camel@intel.com>
References: <4954139.fJS9391jLT@c100> <62c11a15028d27d3c4f50c2d34f47be02b15c965.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:xgUmUdgzyecRTF6uRdDBw7OLBSWfToS3F2nGBxRdhL58P5JnPWK
 YcQm6yG1Tmp3X6wovyeBK1+Jqppt0Lh+7j7zZTLUSk3Pud3E5tQ9uMbYiu7a+KzkcQiYCWv
 iLrsC2NkP38LRrfGi/mLXOUF1shZDkUAJSYnMmHQsZ5IbATZ2C05v21XdJT0RjZhesVEB+z
 ewMbC3Z7XssIWQ3eWBJ0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0bUDOShmu2s=:7ktGxkPYY618gxWSgEfTw9
 faewZWprgN4SI7nm6GbTnAFtaRJEC0X6kx/Gom17c3eaOYAb4gyaaxjxWrtTPr2Ns6a4tmsxw
 0r5H7Yt7U6LDgJtZSh/CjbM+YKUUnmKljgMrZPhHG1vuZGS1PUdFiODm2gCQCeS3dtdiDkpHz
 i9kpVvfwCllbzFYc90zU9PigABEfrL+gKcBKPDl2eC3YRbRBxR7pigvd6G3HKB5gqZXQ0VZJ7
 jAwB+AwgmjH15VQbkSFFScN6HDS3aXz2bb6zOCf32bx70DMsxDYGq1QaSSAN7p/qE/Xhe9Zp/
 c9YLfLCaK1NGPp/eChpDW0WhrRk/hEPD6LwvsIzgZbD1xBQUBhiWnTQNV7riIL9Av6GErz4sy
 QMUAbHHFd83wfuMiMxCWbaUyF6KbfSA28c4g7IMmqzs7wQ7HOZrpyVMKtvqqz4prNdBrmpXm2
 nONcx6g8PoZxF0YezpePiA/ilNQytX0D3w8Y238K1RFicQ4t2TPFOFXJuUTg1d5G8Br+VI9l1
 y1NAd3Ix8bKWKHWpMYVbz31wT8aXdX6aP3fsL28h9ZYsRaxYx0HkthcplwXJ9YB0JnB/c04iH
 pBBeVis4FmMkJpN43mqMbO4wJPYe4zMvwsjWjZ7yO2WGay+AuC1BZ3UjSlcZy0cym5l+haf06
 s+qZMX0rPH4xHxZbL/B5xKRUVSd0eiFS/gGounCEj+SybLpfIYlZX8j8gF9ImfO0E4R79/Lp2
 hKt7VoQcCiumH5GerU4zQtpRJd4tHR2OnePNnQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,

long time no write... ;)
Thanks a lot for having look.

I am currently moving, the usual time problem, sigh.
I will test the way I sent patches first and come up with another version.
But probably not before Mo.
The patches have been in SUSE cpupower package for some time.
I finally find the time to post them, will do again asap.

         Thomas

Am Mittwoch, 20. Juli 2022, 11:45:08 CEST schrieb Zhang Rui:
> Hi, Thomas,
> 
> I want to give the patches a try but it seems that the patch format is
> corrupted, and I can not find them in patchwork neither.





