Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0E19E987
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDEGAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 02:00:50 -0400
Received: from mout.web.de ([212.227.17.11]:55735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgDEGAu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Apr 2020 02:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586066434;
        bh=8Hjb/6oy+4z9cq4CzHtB5MD1bqymNKeupf5xSTpBius=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KXlNwFk7zbAjktFkCOELyQ2T/yHyDxCkwXr7yR/pYHtQ6OTV7PTo7pbH2MQK+HbLt
         g+40T6XVQSEWvncfA3cqvwXMWgIY8voZm4Cnb7diYfrxyIJOvO7flz1EDP8xQdvTmR
         bxb8siqKrrihX1sttbpK+EraJWNhvtzIG2D+o4ts=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyZi-1jAZKa073K-012ZvH; Sun, 05
 Apr 2020 08:00:34 +0200
Subject: Re: PM / devfreq: tegra30: Delete an error message in
 tegra_devfreq_probe()
To:     Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
References: <ba67e238-43a7-6c53-363e-7a2c12f09949@web.de>
 <27bdd09b-0b8d-a6ef-2ffd-53421277fcca@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <72e2319e-9b9b-9045-c007-320b2be1e886@web.de>
Date:   Sun, 5 Apr 2020 08:00:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <27bdd09b-0b8d-a6ef-2ffd-53421277fcca@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:aFlkjLi4mBvfQuNv48u/JJ40lgXxpTtqmsEX+cE6vMZcrV0tLWK
 IiEyQtZ44pBy6Zd8QpquUSYzJf52nFSp61DmIFeZGJv2E6C/AetVMaJuNb1PCxqGbUy57qr
 6tJN1sHouUR+HH34J8U5pySvx8e44r0rVWC4GuGlqiqQk7gVQtSPZa6XkzN/wNNUXKUc7Hp
 rd1Bg+5MK9nR/hzwkXNKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1sckxbfIqCw=:TbU7xGYCA4JwKEnuVGz8lH
 PR5CNSI2GrazXLBkygAsrxhgiROT0y23PgdLyH+3ZB/VZV6z6v2z5MOjoUfgfpNcxNTHCFjVJ
 GvQWftybrYL9rK6dA+IlB+vvPyZo1KVsKVxnDQyRaTcuwA9EP5vhzjed5SQ+tQkrwGfNzvzoK
 EL1uWHZqLvPuku97N/T6NyiAyTwXV2RMcNw9kZi9F5aaZb4fVLbIftc3quq3PvIKKCeCrI6f+
 Q0nnUEF02xoQ8W1ywuxPnH8N3bIs9W2ttBsVKCWVaSUv6ExPHReizFiClcLu+ABZd7d/isc2Z
 Adw3JBSwMxtfR4PJKukPvFWMjOv/B09oWKLfxUeCj4ks84WWuhGuoHfMj3rz0PX5jvWkOlJoc
 PIo4E53dUm2b3v1Ec54IVRXr25uCrh4mguqVrv9mJkDgdu10TqlQ/tklbMGEHEem9JWT+9m+9
 3Z+LkpDGt3hSE626TgyQzp1DdrK+1IPhpcINNG+ZKC3dDp1ccxeB29eEbBC1KzBItmRKkxj8i
 SXbYCwFXSetyw2qnbQy3E3NzRzjGbQYvtl9y+VOLnUpG4jrKcNOt4zNcvjbsal+BrDqhDd5RK
 qP+Dvkx+GDjctGpNmXeD5aoHQeept18TZTm0KIJiJgi5XKqpYOj9DWzyFAzZHk9/OlHL7F9Yh
 /4uuZ0/mHGao7Pknrv2kVEEFgICY5KSUOPojvPnH1Owh6vm6l5aUYQbWJqGxi8ZTagsEehTru
 jW86VMFfznF+DZ1urJUAKz88iSQmmLmVVaO2byzA56OGjlbeA7FZFK9Sgd6lrUPUMMHrHExj7
 sDKLCc2Pmllh9PCTwhIpz6hlncmQ4/YNwa1utBPKSsccgmKjMzx3/zKWSe1WeG0mo6YPSPZIl
 YXuUabKIZ02Sb1QpdJ1xIYnB5pYtYNJiZiDrtjdnj/T4C+1rPALTH4YW73gtfZOutFodyJSL/
 CpzzxDUlQ3hcHdozx5FR4WlJ0doUqDvFMqhf6VmFM4HqpeP3XyseTy3od8px3aGq4NNOPCGKd
 ukm7i9qN63Eba8MIiKihJBDh2gYeYQQ9fYmTiIyZqZXjxr3htR9Cm6Xy5xfKVq8Axq9UUdhPI
 Mmc84r3DDOwTkb0pMz8EDN2JsMxYZOl0gPnRtmq10ozxQhgSYozS+9tR1KAWSk2+AlGp6HUA2
 PAmMEo/gXii01/AxC3k2FKPv3sOjr9nuLD9ByTwAPdRyWUfGaIZCH+gMj7nTiQGtk7uko5yLh
 PXH7q1k4hjrS28Ye/
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

Thanks for your positive feedback.

Will the logging of error codes need any more clarification
around such function calls?

Regards,
Markus
