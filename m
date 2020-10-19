Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B329260D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgJSKvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 06:51:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:32360 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgJSKvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 06:51:02 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201019105059epoutp025905ebaed089d9913f4bd2eb97aca45f~-XzHRUreb3202432024epoutp02y
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 10:50:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201019105059epoutp025905ebaed089d9913f4bd2eb97aca45f~-XzHRUreb3202432024epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603104659;
        bh=OzQ7STniOEoozCj5rps6lC/duRi6vaMoeaAUetDjqf8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DBpzAKr5e6AxrydXt1kaCEwrVodPqLbVeN/XITNxWgOlHvQYliG2YppH5Fl4RIS32
         cXDAv0gXNcqO4b5qaNuHSndueV5OqNNgz/E/knWCCInNUujm3WJxw6204Mml1ANmgS
         mvI19G0cZwuVjL680QJL+VoJHRo1QDlzOLW6tUFU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201019105058epcas1p4ef33873bc5768424630b409377276b78~-XzGPPJJM1760117601epcas1p4K;
        Mon, 19 Oct 2020 10:50:58 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CFD7c5dmjzMqYkb; Mon, 19 Oct
        2020 10:50:52 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.10.09918.C8F6D8F5; Mon, 19 Oct 2020 19:50:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201019105051epcas1p40d8a8ac9783f8dd817110debd4cfb8fd~-Xy-aV26j1574115741epcas1p49;
        Mon, 19 Oct 2020 10:50:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019105051epsmtrp2e0fa398fe3f5a44a3f5ffdf6d4218a4b~-Xy-Znkwn2270622706epsmtrp2_;
        Mon, 19 Oct 2020 10:50:51 +0000 (GMT)
X-AuditID: b6c32a36-713ff700000026be-e1-5f8d6f8c49e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.A0.08604.B8F6D8F5; Mon, 19 Oct 2020 19:50:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019105051epsmtip1defbca2dbb4676d7c8edc0e09c3c4e95~-Xy-Lvwhm1367713677epsmtip1z;
        Mon, 19 Oct 2020 10:50:51 +0000 (GMT)
Subject: Re: [PATCH 0/3] PM / devfreq: Add devfreq_frequency tracepoint to
 track frequency change
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1763ff8e-e7c7-af36-13b2-1794d109f206@samsung.com>
Date:   Mon, 19 Oct 2020 20:04:16 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201008075403.26181-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmrm5Pfm+8wZ93mhYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFpcOrCAyeLzhseMFrcbV7BZ7Ot4wOTA4TG74SKLR8u+W+wem1Z1snm833eV
        zaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ5xeuIq5oJ274suHb8wNjC2cXYycHBICJhIT7kxg62Lk4hAS2MEo8eL3
        SlYI5xOjxPplN9khnG+MEofvH2OEafnw8gIzRGIvo8TNjScYIZz3jBKfXi9mAqkSFkiWWDK7
        mwXEFhGwkjj9vwOsg1mgjVHi35avzCAJNgEtif0vbrCB2PwCihJXfzwGW8ErYCfRdXY3WDOL
        gKrEqqMgR3FyiAqESZzc1gJVIyhxcuYTsBpOAWuJ76d/gM1kFhCXuPVkPhOELS+x/e0csMUS
        Ais5JPZ2n2eF+MFF4vvSd8wQtrDEq+Nb2CFsKYnP7/ayQdjVEitPHmGDaO5glNiy/wJUs7HE
        /qWTgTZwAG3QlFi/Sx8irCix8/dcRojFfBLvvvawgpRICPBKdLQJQZQoS1x+cJcJwpaUWNze
        yTaBUWkWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9tdiwwAg5vjcxgpOrltkOxklvP+gdYmTi
        YDzEKMHBrCTCGynYFS/Em5JYWZValB9fVJqTWnyI0RQYwBOZpUST84HpPa8k3tDUyNjY2MLE
        0MzU0FBJnPePdke8kEB6YklqdmpqQWoRTB8TB6dUA1PEtq4fL2qVPePbY29//yL47pJG2b3o
        T9sUeU+dWWL4+demExKTy2c5hV0Xq0rTnSX/hf1dGtM84YPFz8r5/oic55Py78h9J36dXWVG
        p6h+8PEz3akXfN8lqK6Nqky3XdLqr1336eIL20+i0tafZlw2ZnHma/gZYLe6r3lOJ+cDsaaN
        kuzXFOcJFjieYXiuVOz+mltGbomj2aRlW/Zl/PxzT3TBzywLo2XJjJfnveBmWGDlxyDU/G76
        DgP7E49jBCXErX1jvm1esKfZoogxgGt/mcauN+2F0Q6rdZQ+JYetNDe4VzPzX0jWvjiR+Yem
        zxC2e/ElT7Mn0kmpXSJm6jb3u4l9n83899u+ErmwT4mlOCPRUIu5qDgRAC5RQwg3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTrc7vzfe4NZBSYuJN66wWJxtesNu
        cXnXHDaLz71HGC0uHVjAZPF5w2NGi9uNK9gs9nU8YHLg8JjdcJHFo2XfLXaPTas62Tze77vK
        5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZpxeuYi5o56748uEbcwNjC2cXIyeHhICJxIeX
        F5hBbCGB3YwSxxZKQcQlJaZdPAoU5wCyhSUOHy7uYuQCKnnLKHH361tWkBphgWSJJbO7WUBs
        EQEridP/O5hBipgF2hgl9jz8wQTR0cco8WtqE1gHm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYS
        XWd3g01iEVCVWHV0JVi9qECYxM4lj5kgagQlTs58AlbDKWAt8f30D7CrmQXUJf7MuwRli0vc
        ejKfCcKWl9j+dg7zBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYJjTEtzB+P2VR/0DjEycTAeYpTgYFYS4Y0U7IoX4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznujcGGckEB6YklqdmpqQWoRTJaJg1OqgantzI1/73/d1mjZeCWAmbU+7Gh+zyuLN6fm
        K+1I/jfnde9LXpfb2m2zt3NcevZYYYbvSkbfiybZG7Zdt1lg7bVZ/9uRtz+ZD7j+kpgQEz3j
        elus2NynG5uZ+aLiMgxfm7U63GS++bLsZvmDkAbjkucKEXmHNQsZL/Ae9LNdlmPyNsp68W8r
        nqLXig98S8zkJdQeiH1IvVEuL9rcHbWAfX99zLl+CxddnRMhG5tjwv5e7nnLxrBpZ9H6LetO
        NAsbyZ2q2Lvvr2v8Fhkmq2NGCwRnm884PPtD/A69M19+ezE/MhdknWo1bzm7dJ7Y1bq/7CXX
        764sirgiHmV46iaT0LPI2tQJZZv/PsmSzzus7qvEUpyRaKjFXFScCAD+pIiVIAMAAA==
X-CMS-MailID: 20201019105051epcas1p40d8a8ac9783f8dd817110debd4cfb8fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008074041epcas1p14111dc3070c66fce8d775e2fbae39f15
References: <CGME20201008074041epcas1p14111dc3070c66fce8d775e2fbae39f15@epcas1p1.samsung.com>
        <20201008075403.26181-1-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/8/20 4:54 PM, Chanwoo Choi wrote:
> Add devfreq_tracepoint to track the correct timing of frequency change
> with following information:
> - device name
> - current frequency
> - previous frequency
> - load when change frequency
> - tracepoint path : /sys/kernel/debug/tracing/events/devfreq_frequency
> 
> And add devfreq_update_target() function to unify the frequency change code
> on both devfreq core and devfreq passive governor because there are redundant
> duplicate code. Lastly, Use fixed indentation size to improve readability
> for 'devfreq_monitor' tracepoint.
> 
> Matthias already sent the patch[1]. Make patch3 by editing patch[1].
> [1]https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2108015.html
> 
> Chanwoo Choi (2):
>   trace: events: devfreq: Use fixed indentation size to improve readability
>   PM / devfreq: Unify frequency change to devfreq_update_target func
> 
> Matthias Kaehlcke (1):
>   PM / devfreq: Add tracepoint for frequency changes
> 
>  drivers/devfreq/devfreq.c          | 37 +++++++++++++++++++++-----
>  drivers/devfreq/governor.h         |  1 +
>  drivers/devfreq/governor_passive.c | 42 +++++++-----------------------
>  include/trace/events/devfreq.h     | 30 ++++++++++++++++++++-
>  4 files changed, 70 insertions(+), 40 deletions(-)
> 

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
