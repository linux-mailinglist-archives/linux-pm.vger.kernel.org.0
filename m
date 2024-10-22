Return-Path: <linux-pm+bounces-16189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3849A9A62
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304641F21800
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192B84E0D;
	Tue, 22 Oct 2024 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkG5S9G/"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA131A269
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580497; cv=none; b=ifPHsvi6izef4DPGZYOtWjJd36sJvluaKNSgxNjnMMEqp7YT0q8PS7t9ruy66+aYoxTuSYo1BtlCRlKOYSgpOE3h7KxRaeLvS6HNk7RHcVHSlN9nnIGhp79ZbJOHWMfw5n5OCcNFAdRj+rLPEvEs6Q7pxEaZcXyEapp0p/YnfeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580497; c=relaxed/simple;
	bh=1IFN1WMU+ULDq+Lq9PaWaAn3Q1KFEEzBdujvZqEBDEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RGyxtAAyj/BbaEaKcWa0B7qSIoVyYrCSwabr0WQdDlWmbk0zl7KFblpwsIB4qfyqe6VbNZRBKwcSdMGSUAnKhIgp4hslSBZLa7TZlGBTeKLblhasNGEYPbAiaiPz+Lx28lg0WhZ7B9Log+sJ6IpTkGIotPYsi69Vkcpp9lHwUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkG5S9G/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729580493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IFKsb7+ewr6Q7Fax6fO/4zd2b0LwKY2kZ/ZzZX/ydcQ=;
	b=DkG5S9G/KXYaBOHTbHS0JWKBMWyZiKUruQT9KB9lnsTgqlOR2gTWt6BuNyzPrTTp8P53VS
	DBCiFPqDxdObTkw72uqZhYvYHmLQ8doKRxFoFNMryYFaa0zZbsp7ImgV8+OfYTxKL9lPRF
	zqqNxs1dVAIAyaq/wJf5bRPEEcqc53s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-i0jG40aNPfi4NVpf2dye5Q-1; Tue,
 22 Oct 2024 03:01:27 -0400
X-MC-Unique: i0jG40aNPfi4NVpf2dye5Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7A319560A2;
	Tue, 22 Oct 2024 07:01:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.175])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA33D19560A2;
	Tue, 22 Oct 2024 07:01:21 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:01:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
	rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ming.lei@redhat.com
Subject: [Bug report] UAF on device runtime PM code 
Message-ID: <ZxdNvLNI8QaOfD2d@fedora>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello,

In RH internal test, the following UAF[1] is triggered at least two times.

From the log, when deleting one scsi_device, pm_request_idle(parent) is
called, so work function is queued on its parent device(scsi_target),
but after the target device is removed & released, the queued work
function isn't drained yet, so finally UAF is triggered.

So it looks like one runtime PM issue.


[1] UAF log
[  266.350498] run blktests block/001 at 2024-09-21 21:53:56 
[  268.052041] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1) 
[  268.065822] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1) 
[  268.074433] scsi 17:0:0:0: Power-on or device reset occurred 
[  268.078618] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1) 
[  268.084150] scsi 18:0:0:0: Power-on or device reset occurred 
[  268.091568] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1) 
[  268.096797] scsi 19:0:0:0: Power-on or device reset occurred 
[  268.107039] scsi 20:0:0:0: Power-on or device reset occurred 
[  269.947267] scsi 18:0:0:0: Power-on or device reset occurred 
[  269.947360] scsi 17:0:0:0: Power-on or device reset occurred 
[  269.963667] scsi 20:0:0:0: Power-on or device reset occurred 
[  269.968753] scsi 19:0:0:0: Power-on or device reset occurred 
[  269.970049] sd 18:0:0:0: [sdb] Asking for cache data failed 
[  269.970122] sd 18:0:0:0: [sdb] Assuming drive cache: write through 
[  269.986788] sd 20:0:0:0: [sdd] Asking for cache data failed 
[  269.986955] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  270.110759] scsi 18:0:0:0: Power-on or device reset occurred 
[  270.119417] scsi 17:0:0:0: Power-on or device reset occurred 
[  270.120667] scsi 20:0:0:0: Power-on or device reset occurred 
[  270.131483] sd 18:0:0:0: [sdb] Asking for cache data failed 
[  270.131550] sd 18:0:0:0: [sdb] Assuming drive cache: write through 
[  270.131997] sd 18:0:0:0: [sdb] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  270.132068] sd 18:0:0:0: [sdb] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  270.134677] scsi 19:0:0:0: Power-on or device reset occurred 
[  270.142234] sd 17:0:0:0: [sdc] No Caching mode page found 
[  270.142276] sd 17:0:0:0: [sdc] Assuming drive cache: write through 
[  270.266136] scsi 20:0:0:0: Power-on or device reset occurred 
[  270.269919] scsi 18:0:0:0: Power-on or device reset occurred 
[  270.276814] scsi 17:0:0:0: Power-on or device reset occurred 
[  270.284092] sd 18:0:0:0: [sdb] Asking for cache data failed 
[  270.284148] sd 18:0:0:0: [sdb] Assuming drive cache: write through 
[  270.290198] sd 20:0:0:0: [sdc] Asking for cache data failed 
[  270.290306] sd 20:0:0:0: [sdc] Assuming drive cache: write through 
[  270.291191] sd 20:0:0:0: [sdc] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  270.291308] sd 20:0:0:0: [sdc] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  270.292456] scsi 19:0:0:0: Power-on or device reset occurred 
[  270.296833] sd 17:0:0:0: [sdd] No Caching mode page found 
[  270.296915] sd 17:0:0:0: [sdd] Assuming drive cache: write through 
[  270.415106] scsi 20:0:0:0: Power-on or device reset occurred 
[  270.418725] scsi 18:0:0:0: Power-on or device reset occurred 
[  270.429457] scsi 17:0:0:0: Power-on or device reset occurred 
[  270.432937] sd 20:0:0:0: [sdb] No Caching mode page found 
[  270.432990] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  270.434687] sd 18:0:0:0: [sdc] No Caching mode page found 
[  270.434765] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  270.443533] scsi 19:0:0:0: Power-on or device reset occurred 
[  270.444195] sd 17:0:0:0: [sdd] Asking for cache data failed 
[  270.444232] sd 17:0:0:0: [sdd] Assuming drive cache: write through 
[  270.457634] sd 19:0:0:0: [sde] No Caching mode page found 
[  270.457683] sd 19:0:0:0: [sde] Assuming drive cache: write through 
[  270.581441] scsi 20:0:0:0: Power-on or device reset occurred 
[  270.597557] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  270.597655] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  270.598512] sd 20:0:0:0: [sdb] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  270.598603] sd 20:0:0:0: [sdb] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  270.606283] scsi 19:0:0:0: Power-on or device reset occurred 
[  270.606819] scsi 18:0:0:0: Power-on or device reset occurred 
[  270.622217] scsi 17:0:0:0: Power-on or device reset occurred 
[  270.622898] sd 19:0:0:0: [sdc] No Caching mode page found 
[  270.622953] sd 19:0:0:0: [sdc] Assuming drive cache: write through 
[  270.639791] sd 17:0:0:0: [sde] Asking for cache data failed 
[  270.639898] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  270.719881] scsi 20:0:0:0: Power-on or device reset occurred 
[  270.749329] scsi 19:0:0:0: Power-on or device reset occurred 
[  270.752904] scsi 18:0:0:0: Power-on or device reset occurred 
[  270.762110] scsi 17:0:0:0: Power-on or device reset occurred 
[  270.789428] sd 17:0:0:0: [sde] Asking for cache data failed 
[  270.789511] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  270.858873] scsi 20:0:0:0: Power-on or device reset occurred 
[  270.876715] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  270.876782] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  270.877211] sd 20:0:0:0: [sdb] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  270.877258] sd 20:0:0:0: [sdb] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  270.934373] scsi 18:0:0:0: Power-on or device reset occurred 
[  270.940506] scsi 17:0:0:0: Power-on or device reset occurred 
[  270.950315] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  270.950451] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  270.952725] scsi 19:0:0:0: Power-on or device reset occurred 
[  270.969098] sd 19:0:0:0: [sde] Asking for cache data failed 
[  270.969162] sd 19:0:0:0: [sde] Assuming drive cache: write through 
[  270.969490] sd 19:0:0:0: [sde] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  270.969529] sd 19:0:0:0: [sde] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  270.990422] scsi 20:0:0:0: Power-on or device reset occurred 
[  271.006532] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  271.006601] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  271.084253] scsi 17:0:0:0: Power-on or device reset occurred 
[  271.100780] scsi 18:0:0:0: Power-on or device reset occurred 
[  271.101813] sd 17:0:0:0: [sdc] Asking for cache data failed 
[  271.101957] sd 17:0:0:0: [sdc] Assuming drive cache: write through 
[  271.119571] scsi 19:0:0:0: Power-on or device reset occurred 
[  271.150888] scsi 20:0:0:0: Power-on or device reset occurred 
[  271.164604] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  271.164665] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  271.237757] scsi 17:0:0:0: Power-on or device reset occurred 
[  271.260960] scsi 18:0:0:0: Power-on or device reset occurred 
[  271.275988] sd 18:0:0:0: [sdd] No Caching mode page found 
[  271.276037] sd 18:0:0:0: [sdd] Assuming drive cache: write through 
[  271.292954] scsi 20:0:0:0: Power-on or device reset occurred 
[  271.303981] scsi 19:0:0:0: Power-on or device reset occurred 
[  271.312095] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  271.312159] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  271.328767] sd 19:0:0:0: [sde] Asking for cache data failed 
[  271.328902] sd 19:0:0:0: [sde] Assuming drive cache: write through 
[  271.329272] sd 19:0:0:0: [sde] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  271.329315] sd 19:0:0:0: [sde] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  271.425788] scsi 17:0:0:0: Power-on or device reset occurred 
[  271.434525] scsi 18:0:0:0: Power-on or device reset occurred 
[  271.448686] scsi 20:0:0:0: Power-on or device reset occurred 
[  271.451425] scsi 19:0:0:0: Power-on or device reset occurred 
[  271.453932] sd 18:0:0:0: [sdb] Asking for cache data failed 
[  271.453987] sd 18:0:0:0: [sdb] Assuming drive cache: write through 
[  271.588871] scsi 17:0:0:0: Power-on or device reset occurred 
[  271.589409] scsi 18:0:0:0: Power-on or device reset occurred 
[  271.604871] scsi 19:0:0:0: Power-on or device reset occurred 
[  271.605924] scsi 20:0:0:0: Power-on or device reset occurred 
[  271.622771] sd 19:0:0:0: [sdd] No Caching mode page found 
[  271.622839] sd 19:0:0:0: [sdd] Assuming drive cache: write through 
[  271.731088] scsi 17:0:0:0: Power-on or device reset occurred 
[  271.746053] sd 17:0:0:0: [sdb] Asking for cache data failed 
[  271.746130] sd 17:0:0:0: [sdb] Assuming drive cache: write through 
[  271.746570] sd 17:0:0:0: [sdb] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  271.746628] sd 17:0:0:0: [sdb] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  271.758354] scsi 19:0:0:0: Power-on or device reset occurred 
[  271.761641] scsi 18:0:0:0: Power-on or device reset occurred 
[  271.767706] scsi 20:0:0:0: Power-on or device reset occurred 
[  271.771721] sd 19:0:0:0: [sdc] Asking for cache data failed 
[  271.771757] sd 19:0:0:0: [sdc] Assuming drive cache: write through 
[  271.785742] sd 20:0:0:0: [sde] Asking for cache data failed 
[  271.785818] sd 20:0:0:0: [sde] Assuming drive cache: write through 
[  271.869429] scsi 17:0:0:0: Power-on or device reset occurred 
[  271.885341] sd 17:0:0:0: [sdb] No Caching mode page found 
[  271.885572] sd 17:0:0:0: [sdb] Assuming drive cache: write through 
[  271.911435] scsi 19:0:0:0: Power-on or device reset occurred 
[  271.915383] scsi 18:0:0:0: Power-on or device reset occurred 
[  271.926743] sd 19:0:0:0: [sdc] No Caching mode page found 
[  271.926829] sd 19:0:0:0: [sdc] Assuming drive cache: write through 
[  271.928838] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.009223] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.026092] sd 17:0:0:0: [sdb] Asking for cache data failed 
[  272.026146] sd 17:0:0:0: [sdb] Assuming drive cache: write through 
[  272.057230] scsi 18:0:0:0: Power-on or device reset occurred 
[  272.058875] scsi 19:0:0:0: Power-on or device reset occurred 
[  272.076661] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  272.076702] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  272.077099] sd 18:0:0:0: [sdc] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  272.077140] sd 18:0:0:0: [sdc] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  272.078360] sd 19:0:0:0: [sdd] Asking for cache data failed 
[  272.078415] sd 19:0:0:0: [sdd] Assuming drive cache: write through 
[  272.081739] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.188144] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.191024] scsi 19:0:0:0: Power-on or device reset occurred 
[  272.194438] scsi 18:0:0:0: Power-on or device reset occurred 
[  272.202942] sd 17:0:0:0: [sdb] Asking for cache data failed 
[  272.202993] sd 17:0:0:0: [sdb] Assuming drive cache: write through 
[  272.215618] sd 18:0:0:0: [sdd] Asking for cache data failed 
[  272.215727] sd 18:0:0:0: [sdd] Assuming drive cache: write through 
[  272.282396] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.297707] sd 20:0:0:0: [sde] Asking for cache data failed 
[  272.297749] sd 20:0:0:0: [sde] Assuming drive cache: write through 
[  272.324982] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.368956] scsi 18:0:0:0: Power-on or device reset occurred 
[  272.369455] scsi 19:0:0:0: Power-on or device reset occurred 
[  272.389105] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  272.389175] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  272.394620] sd 19:0:0:0: [sdd] No Caching mode page found 
[  272.394685] sd 19:0:0:0: [sdd] Assuming drive cache: write through 
[  272.450572] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.463200] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.466343] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  272.466417] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  272.480972] sd 17:0:0:0: [sde] Asking for cache data failed 
[  272.481053] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  272.503539] scsi 18:0:0:0: Power-on or device reset occurred 
[  272.513930] scsi 19:0:0:0: Power-on or device reset occurred 
[  272.523649] sd 18:0:0:0: [sdc] No Caching mode page found 
[  272.523690] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  272.593210] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.612572] sd 20:0:0:0: [sdb] No Caching mode page found 
[  272.612596] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.612629] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  272.624836] sd 17:0:0:0: [sde] Asking for cache data failed 
[  272.624873] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  272.664446] scsi 18:0:0:0: Power-on or device reset occurred 
[  272.684257] scsi 19:0:0:0: Power-on or device reset occurred 
[  272.685551] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  272.685586] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  272.685895] sd 18:0:0:0: [sdc] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  272.685934] sd 18:0:0:0: [sdc] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  272.700266] sd 19:0:0:0: [sdd] Asking for cache data failed 
[  272.700321] sd 19:0:0:0: [sdd] Assuming drive cache: write through 
[  272.700721] sd 19:0:0:0: [sdd] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  272.700799] sd 19:0:0:0: [sdd] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  272.778925] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.800617] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  272.800742] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  272.801294] sd 20:0:0:0: [sdb] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  272.801360] sd 20:0:0:0: [sdb] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  272.804754] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.820400] sd 17:0:0:0: [sde] Asking for cache data failed 
[  272.820462] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  272.846164] scsi 18:0:0:0: Power-on or device reset occurred 
[  272.849320] scsi 19:0:0:0: Power-on or device reset occurred 
[  272.862480] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  272.862522] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  272.864116] sd 19:0:0:0: [sdd] No Caching mode page found 
[  272.864155] sd 19:0:0:0: [sdd] Assuming drive cache: write through 
[  272.928979] scsi 20:0:0:0: Power-on or device reset occurred 
[  272.942007] scsi 17:0:0:0: Power-on or device reset occurred 
[  272.944832] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  272.944886] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  272.958577] sd 17:0:0:0: [sde] No Caching mode page found 
[  272.958618] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  273.003596] scsi 18:0:0:0: Power-on or device reset occurred 
[  273.010422] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.032036] sd 19:0:0:0: [sdd] Asking for cache data failed 
[  273.032110] sd 19:0:0:0: [sdd] Assuming drive cache: write through 
[  273.072788] scsi 20:0:0:0: Power-on or device reset occurred 
[  273.087570] scsi 17:0:0:0: Power-on or device reset occurred 
[  273.088308] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  273.088345] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  273.104825] sd 17:0:0:0: [sde] Asking for cache data failed 
[  273.104910] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  273.162867] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.173736] scsi 18:0:0:0: Power-on or device reset occurred 
[  273.177011] sd 19:0:0:0: [sdc] Asking for cache data failed 
[  273.177064] sd 19:0:0:0: [sdc] Assuming drive cache: write through 
[  273.187549] sd 18:0:0:0: [sdd] Asking for cache data failed 
[  273.187608] sd 18:0:0:0: [sdd] Assuming drive cache: write through 
[  273.210899] scsi 20:0:0:0: Power-on or device reset occurred 
[  273.237422] sd 20:0:0:0: [sdb] Asking for cache data failed 
[  273.237508] sd 20:0:0:0: [sdb] Assuming drive cache: write through 
[  273.238070] sd 20:0:0:0: [sdb] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  273.238143] sd 20:0:0:0: [sdb] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  273.260554] scsi 17:0:0:0: Power-on or device reset occurred 
[  273.274515] sd 17:0:0:0: [sde] Asking for cache data failed 
[  273.274570] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  273.326838] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.350389] scsi 18:0:0:0: Power-on or device reset occurred 
[  273.352933] sd 19:0:0:0: [sdb] No Caching mode page found 
[  273.352991] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  273.358086] scsi 20:0:0:0: Power-on or device reset occurred 
[  273.372042] sd 20:0:0:0: [sdd] Asking for cache data failed 
[  273.372092] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  273.431090] scsi 17:0:0:0: Power-on or device reset occurred 
[  273.446201] sd 17:0:0:0: [sde] Asking for cache data failed 
[  273.446243] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  273.485450] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.498320] scsi 18:0:0:0: Power-on or device reset occurred 
[  273.508925] scsi 20:0:0:0: Power-on or device reset occurred 
[  273.528767] sd 20:0:0:0: [sdd] No Caching mode page found 
[  273.528838] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  273.579691] scsi 17:0:0:0: Power-on or device reset occurred 
[  273.603622] sd 17:0:0:0: [sde] Asking for cache data failed 
[  273.603789] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  273.646011] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.669362] sd 19:0:0:0: [sdb] No Caching mode page found 
[  273.669420] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  273.682688] scsi 18:0:0:0: Power-on or device reset occurred 
[  273.697323] sd 18:0:0:0: [sdc] No Caching mode page found 
[  273.697377] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  273.698097] scsi 20:0:0:0: Power-on or device reset occurred 
[  273.713642] sd 20:0:0:0: [sdd] No Caching mode page found 
[  273.713698] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  273.748161] scsi 17:0:0:0: Power-on or device reset occurred 
[  273.787373] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.805243] sd 19:0:0:0: [sdb] No Caching mode page found 
[  273.805309] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  273.818603] scsi 18:0:0:0: Power-on or device reset occurred 
[  273.834764] sd 18:0:0:0: [sdc] No Caching mode page found 
[  273.834832] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  273.839018] scsi 20:0:0:0: Power-on or device reset occurred 
[  273.852846] sd 20:0:0:0: [sdd] No Caching mode page found 
[  273.852904] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  273.905208] scsi 17:0:0:0: Power-on or device reset occurred 
[  273.921924] sd 17:0:0:0: [sde] Asking for cache data failed 
[  273.922044] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  273.922931] sd 17:0:0:0: [sde] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  273.923044] sd 17:0:0:0: [sde] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  273.935237] scsi 19:0:0:0: Power-on or device reset occurred 
[  273.950813] sd 19:0:0:0: [sdb] Asking for cache data failed 
[  273.950900] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  274.014618] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.030901] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.045827] sd 20:0:0:0: [sdd] Asking for cache data failed 
[  274.045884] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  274.046289] sd 20:0:0:0: [sdd] Preferred minimum I/O size 512 bytes not a multiple of physical block size (0 bytes) 
[  274.046344] sd 20:0:0:0: [sdd] Optimal transfer size 524288 bytes not a multiple of physical block size (0 bytes) 
[  274.063300] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.076697] sd 17:0:0:0: [sde] Asking for cache data failed 
[  274.076847] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  274.114041] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.161582] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.178418] sd 18:0:0:0: [sdc] No Caching mode page found 
[  274.178483] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  274.183661] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.201427] sd 20:0:0:0: [sdd] No Caching mode page found 
[  274.201498] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  274.216491] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.237380] sd 17:0:0:0: [sde] Asking for cache data failed 
[  274.237511] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  274.267686] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.304334] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.318935] sd 18:0:0:0: [sdc] No Caching mode page found 
[  274.318980] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  274.320158] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.340369] sd 20:0:0:0: [sdd] No Caching mode page found 
[  274.340432] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  274.374364] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.391572] sd 17:0:0:0: [sde] No Caching mode page found 
[  274.391613] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  274.404607] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.420871] sd 19:0:0:0: [sdb] No Caching mode page found 
[  274.420925] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  274.447452] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.462355] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  274.462457] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  274.493376] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.509396] sd 20:0:0:0: [sdd] Asking for cache data failed 
[  274.509441] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  274.520286] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.550512] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.563359] sd 19:0:0:0: [sdb] Asking for cache data failed 
[  274.563415] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  274.601984] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.609240] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.623339] sd 18:0:0:0: [sdc] Asking for cache data failed 
[  274.623398] sd 18:0:0:0: [sdc] Assuming drive cache: write through 
[  274.629356] sd 20:0:0:0: [sdd] No Caching mode page found 
[  274.629413] sd 20:0:0:0: [sdd] Assuming drive cache: write through 
[  274.686057] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.688904] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.707569] sd 19:0:0:0: [sde] Asking for cache data failed 
[  274.707617] sd 19:0:0:0: [sde] Assuming drive cache: write through 
[  274.747622] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.762059] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.821915] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.822770] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.839395] sd 19:0:0:0: [sdb] Asking for cache data failed 
[  274.839449] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  274.892761] scsi 18:0:0:0: Power-on or device reset occurred 
[  274.909561] scsi 20:0:0:0: Power-on or device reset occurred 
[  274.955752] scsi 19:0:0:0: Power-on or device reset occurred 
[  274.977962] sd 19:0:0:0: [sdb] Asking for cache data failed 
[  274.978037] sd 19:0:0:0: [sdb] Assuming drive cache: write through 
[  274.982214] scsi 17:0:0:0: Power-on or device reset occurred 
[  274.997114] sd 17:0:0:0: [sde] Asking for cache data failed 
[  274.997187] sd 17:0:0:0: [sde] Assuming drive cache: write through 
[  275.045587] ================================================================== 
[  275.045600] BUG: KASAN: slab-use-after-free in __lock_acquire+0x1796/0x1ad0 
[  275.045622] Read of size 8 at addr ffff8883467ae1a8 by task kworker/46:0/300 
[  275.045634]  
[  275.045641] CPU: 46 UID: 0 PID: 300 Comm: kworker/46:0 Kdump: loaded Not tainted 6.11.0-0.rc5.22.el10.x86_64+debug #1 
[  275.045657] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.21.2 02/19/2024 
[  275.045665] Workqueue: pm pm_runtime_work 
[  275.045685] Call Trace: 
[  275.045692]  <TASK> 
[  275.045703]  dump_stack_lvl+0x6f/0xb0 
[  275.045724]  ? __lock_acquire+0x1796/0x1ad0 
[  275.045735]  print_address_description.constprop.0+0x88/0x330 
[  275.045759]  ? __lock_acquire+0x1796/0x1ad0 
[  275.045772]  print_report+0x108/0x209 
[  275.045785]  ? __lock_acquire+0x1796/0x1ad0 
[  275.045796]  ? __virt_addr_valid+0x20b/0x440 
[  275.045813]  ? __lock_acquire+0x1796/0x1ad0 
[  275.045825]  kasan_report+0xa8/0xe0 
[  275.045845]  ? __lock_acquire+0x1796/0x1ad0 
[  275.045870]  __lock_acquire+0x1796/0x1ad0 
[  275.045900]  lock_acquire.part.0+0x11b/0x360 
[  275.045912]  ? rpm_suspend+0xc59/0xea0 
[  275.045931]  ? __pfx_lock_acquire.part.0+0x10/0x10 
[  275.045952]  ? rcu_is_watching+0x15/0xb0 
[  275.045969]  ? lock_acquire+0x234/0x2f0 
[  275.045981]  ? rpm_suspend+0xc51/0xea0 
[  275.045999]  _raw_spin_lock+0x37/0x80 
[  275.046009]  ? rpm_suspend+0xc59/0xea0 
[  275.046021]  rpm_suspend+0xc59/0xea0 
[  275.046041]  ? __pfx_rpm_suspend+0x10/0x10 
[  275.046056]  ? rcu_is_watching+0x15/0xb0 
[  275.046070]  ? trace_rpm_return_int+0x185/0x200 
[  275.046084]  ? __pfx_scsi_runtime_idle+0x10/0x10 
[  275.046103]  ? rpm_idle+0x2df/0x620 
[  275.046120]  pm_runtime_work+0xeb/0x130 
[  275.046136]  process_one_work+0x8de/0x15f0 
[  275.046175]  ? __pfx_process_one_work+0x10/0x10 
[  275.046205]  ? assign_work+0x16c/0x240 
[  275.046227]  worker_thread+0x5e6/0xf90 
[  275.046262]  ? __pfx_worker_thread+0x10/0x10 
[  275.046276]  kthread+0x2d2/0x3a0 
[  275.046288]  ? _raw_spin_unlock_irq+0x28/0x50 
[  275.046300]  ? __pfx_kthread+0x10/0x10 
[  275.046315]  ret_from_fork+0x31/0x70 
[  275.046329]  ? __pfx_kthread+0x10/0x10 
[  275.046341]  ret_from_fork_asm+0x1a/0x30 
[  275.046381]  </TASK> 
[  275.046386]  
[  275.046391] Allocated by task 4501: 
[  275.046398]  kasan_save_stack+0x30/0x50 
[  275.046409]  kasan_save_track+0x14/0x30 
[  275.046417]  __kasan_kmalloc+0x8f/0xa0 
[  275.046426]  __kmalloc_noprof+0x1fe/0x410 
[  275.046440]  scsi_alloc_target+0x115/0xae0 
[  275.046453]  __scsi_scan_target+0xf1/0x3b0 
[  275.046464]  scsi_scan_host_selected+0x24c/0x2b0 
[  275.046475]  store_scan+0x33d/0x3b0 
[  275.046485]  kernfs_fop_write_iter+0x3a5/0x5b0 
[  275.046498]  vfs_write+0x5e4/0xe70 
[  275.046507]  ksys_write+0xfb/0x1d0 
[  275.046516]  do_syscall_64+0x92/0x180 
[  275.046529]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
[  275.046542]  
[  275.046546] Freed by task 4501: 
[  275.046552]  kasan_save_stack+0x30/0x50 
[  275.046561]  kasan_save_track+0x14/0x30 
[  275.046569]  kasan_save_free_info+0x3b/0x70 
[  275.046583]  poison_slab_object+0x109/0x180 
[  275.046592]  __kasan_slab_free+0x14/0x30 
[  275.046600]  kfree+0x12b/0x3d0 
[  275.046611]  scsi_target_dev_release+0x36/0x50 
[  275.046622]  device_release+0x9c/0x210 
[  275.046631]  kobject_cleanup+0x102/0x360 
[  275.046645]  device_release+0x9c/0x210 
[  275.046652]  kobject_cleanup+0x102/0x360 
[  275.046663]  scsi_device_put+0x78/0xa0 
[  275.046677]  sdev_store_delete+0x9f/0x120 
[  275.046687]  kernfs_fop_write_iter+0x3a5/0x5b0 
[  275.046698]  vfs_write+0x5e4/0xe70 
[  275.046706]  ksys_write+0xfb/0x1d0 
[  275.046714]  do_syscall_64+0x92/0x180 
[  275.046726]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
[  275.046736]  
[  275.046740] Last potentially related work creation: 
[  275.046745]  kasan_save_stack+0x30/0x50 
[  275.046753]  __kasan_record_aux_stack+0x8e/0xa0 
[  275.046765]  insert_work+0x36/0x310 
[  275.046777]  __queue_work+0x732/0xbb0 
[  275.046785]  queue_work_on+0x74/0xb0 
[  275.046793]  rpm_idle+0x592/0x620 
[  275.046802]  __pm_runtime_set_status+0x260/0x680 
[  275.046813]  pm_runtime_remove+0xce/0x170 
[  275.046824]  device_pm_remove+0x1b2/0x330 
[  275.046832]  device_del+0x3c9/0x9c0 
[  275.046843]  __scsi_remove_device+0x276/0x340 
[  275.046853]  sdev_store_delete+0x87/0x120 
[  275.046862]  kernfs_fop_write_iter+0x3a5/0x5b0 
[  275.046873]  vfs_write+0x5e4/0xe70 
[  275.046881]  ksys_write+0xfb/0x1d0 
[  275.046889]  do_syscall_64+0x92/0x180 
[  275.046901]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
[  275.046911]  
[  275.046915] The buggy address belongs to the object at ffff8883467ae000 
[  275.046915]  which belongs to the cache kmalloc-2k of size 2048 
[  275.046925] The buggy address is located 424 bytes inside of 
[  275.046925]  freed 2048-byte region [ffff8883467ae000, ffff8883467ae800) 
[  275.046936]  
[  275.046940] The buggy address belongs to the physical page: 
[  275.046947] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3467a8 
[  275.046958] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0 
[  275.046966] anon flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff) 
[  275.046980] page_type: 0xfdffffff(slab) 
[  275.046992] raw: 0017ffffc0000040 ffff88810004cf00 0000000000000000 0000000000000001 
[  275.047003] raw: 0000000000000000 0000000000080008 00000001fdffffff 0000000000000000 
[  275.047012] head: 0017ffffc0000040 ffff88810004cf00 0000000000000000 0000000000000001 
[  275.047021] head: 0000000000000000 0000000000080008 00000001fdffffff 0000000000000000 
[  275.047029] head: 0017ffffc0000003 ffffea000d19ea01 ffffffffffffffff 0000000000000000 
[  275.047038] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000 
[  275.047044] page dumped because: kasan: bad access detected 
[  275.047049]  
[  275.047053] Memory state around the buggy address: 
[  275.047059]  ffff8883467ae080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  275.047068]  ffff8883467ae100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  275.047075] >ffff8883467ae180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  275.047081]                                   ^ 
[  275.047087]  ffff8883467ae200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  275.047094]  ffff8883467ae280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[  275.047100] ================================================================== 
[  275.047106] Disabling lock debugging due to kernel taint 
[  275.050576] scsi 18:0:0:0: Power-on or device reset occurred 
[  275.051101] scsi 20:0:0:0: Power-on or device reset occurred 
{code}


-- 
Ming


