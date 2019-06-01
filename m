Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7CFD31F9F
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFAOCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 10:02:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfFAOCm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 10:02:42 -0400
Received: from orion.localdomain ([95.114.112.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUrM-1gfeyh2gPS-00rU8U; Sat, 01 Jun 2019 16:01:45 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, aacraid@microsemi.com,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: remove unneeded #ifdef MODULE
Date:   Sat,  1 Jun 2019 16:01:37 +0200
Message-Id: <1559397700-15585-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:hGTgP1y7zY+DVXA/rOYqRPbljVCiVHRqPra8wSw4Lkfo1xHjwNn
 eK9ZzEYzFoatUXTklAva012EmlLrpLSb5plOGiEEGxCWI39nTOi/JdUF5xvW8bmZeubpcSc
 xc8pnImbQFOUGhhWZLVGngY7hE7GncvcAlxymgO3klVT6wdQkYncmMKsMOeeuEsQKS0QShc
 StwfyiM1ZO9f+Gk1pPJCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d0/aFr6L5/Q=:dJYAEC1kzUKCKAKaj1w7ME
 FSAvSirVALQTSLvxpmanuY0cyWrJUEcUF64D/ArKTxkOK9sw2FxEmipp29+ADmoAMKkAxUSWM
 VlUckQ3W5mhQCPS4OG22rHvGAZRHAGVGC58h3bOQJVCcg7r3c9ZaH3MFIswYfqDg39zG0919Y
 H6oRs1tUaGqdL6Xy9zaStkgTtFHs7hOeIlGU17FEpdA4wQQFxyihmCcKhIDooSxeJBeDOE5xW
 svi/gvFfIWe/QO8LpJyCyp9FMnHg47NcutYWxd5yvDyXdrS+73TWw/aOiWkg2VZiVCQs8Gcoy
 q9H27W7399HD88fTcZBIv7uyWmk9dODuqr1PoJ0NAgBnEWnS1uYisLZ+QN8oJKlBSa/EgKyn3
 OyScGXWW/H0E4OkggsSp6DVYsn1KPBQXKEt+zTO2lTrHdFiqisk24EfmeMrSqSrWcY7CIvHFe
 kJHhQZ+TiS5EXEACMa/24cIN9Rz5U7L8RmmY3FXdEL1nvmP0zlBlRFXPdWQn9zvxPFLDksBfU
 m1uVq6R/tOm6U3rkF+qAB7lOIkI5nbN4B5JH3y0XFQF5sJRG5ooKitxAjLNEFhWryzGiHij4h
 5zp4maKCCbi83lNTcfG9AS2VdVUzpSyH8jqtOVUO0G9elkHJCIRrVR3bwE/49TXOcBB+WQ+MI
 GVtfS40Gbg/noJkoNf3q6cdxwX545eiBElw20LPpVnpLl8a1ZHpDU7CMANVsa/epfhWqPgh3U
 Uy4qF0JDswsG9vefLymMZZohFAAWJpuiTzibPw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks,

here're some patches that remove some (IMHO) unncessary cases of #ifdef MODULE
These basically switch off calls to MODULE_DEVICE_TABLE() macro, which already
checks for MODULE symbol on its own.

have fun
--mtx 

